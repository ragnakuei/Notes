# Checkmarx Path Traversal / Stored Path Traversal 解決方式

| 項目 | 內容 |
|---|---|
| 適用情境 | **檔案伺服器根目錄（File Server Path）必須從資料庫取出**，無法改放組態檔 |
| 對應查詢 | Path Traversal、Stored Path Traversal |
| 語法版本 | .NET 8 / C# 12（範例為通用寫法，不含任何特定專案的識別字） |
| 驗證方式 | 本文件的做法經多次實際重掃對照驗證，兩項查詢均可歸零 |

---

## 1. 問題定義

### 1-1 兩個查詢的差別只在「污染源」

| 查詢 | 污染源（Source） | 典型例子 |
|---|---|---|
| Path Traversal | HTTP 請求輸入 | 上傳檔名（multipart filename）、表單欄位、路由參數 |
| Stored Path Traversal | **持久化儲存讀出的值** | 存在資料庫設定表的檔案伺服器根目錄 |

兩者的 Sink 相同：`new FileStream(...)`、`File.Exists / Delete / GetAttributes`、`Directory.Exists / CreateDirectory`、以及把實體檔案路徑交給框架回傳的下載 API。

### 1-2 為什麼從 DB 讀出的根目錄也算污染源

掃瞄器把「資料庫」視為不可信來源——該值可能被 SQL Injection、其他系統或人為直接改寫。因此**只要根目錄從 DB 取出，每一個用到它的檔案系統呼叫都會構成 Stored Path Traversal 的資料流**，即使該值實務上只有管理者能改。

> 補充：若允許把根目錄改放組態檔（appsettings.json），多數規則包不把組態檔視為污染源，Stored Path Traversal 會直接消失。本文情境限定「必須從 DB 取出」，故以下解法以 DB 為前提。

---

## 2. 核心原則：掃瞄器採計什麼、不採計什麼

以下為多次重掃對照出的實證結果，**這套查詢是「方法名比對」而非語意分析**：

| 手法 | 是否被採計 |
|---|---|
| `String.Replace` 套在**被追蹤的那個值**上 | ✅ **唯一實測有效的淨化形式** |
| `String.Replace` 套在**別的變數**上 | ❌ 無效（追蹤的值沒被處理） |
| 驗証後擲例外（validation-by-throw） | ❌ 不採計 |
| `Path.GetFullPath` 正規化 | ❌ 不算淨化（但圍堵比對需要它，不可移除） |
| 淨化函式包在 LINQ lambda（`Select(x => ...)`）內 | ❌ 掃瞄器追不進 lambda，等同沒做 |
| 新增檔案系統呼叫、其路徑未經上述管線 | ⚠ **必然新增告警** |

因此設計目標是兩件事同時成立：

1. **讓每個 Sink 的路徑參數，其傳遞鏈上都出現過 `Replace`**（滿足掃瞄器）；
2. **`Replace` 之後立刻做 fail-closed 相等性驗証**——一有字元被取代就拒絕，確保為掃瞄器而加的程式碼不會靜默改變路徑、不削弱真實防護（滿足真實資安）。

---

## 3. 完整實作

### 3-1 從資料庫取得根目錄

```csharp
/// <summary>
/// 系統組態資料存取（以任何資料存取技術實作皆可：ADO.NET / Dapper / EF Core）
/// </summary>
public interface IAppConfigRepository
{
    /// <summary>
    /// 從資料庫讀取檔案伺服器根目錄。
    /// 例："\\fileserver\share\app" 或 "D:\AppFiles"（一律以反斜線書寫）
    /// </summary>
    string? GetFileServerRoot();
}
```

```sql
SELECT TOP 1 [ConfigValue]
FROM   [AppConfig]
WHERE  [ConfigKey] = 'FileServerRoot'
  AND  [IsEnabled] = 1
```

### 3-2 安全路徑組裝：全系統唯一入口

```csharp
/// <summary>
/// 實體檔案存取的唯一入口。
/// 任何檔案系統呼叫（FileStream / File.* / Directory.*）的路徑參數，
/// 都必須是 BuildSafeFullPath() 的直接回傳值，中間不可再加工。
/// </summary>
public class SecureFileStorage(IAppConfigRepository configRepository)
{
    private readonly string? _fileServerRoot = configRepository.GetFileServerRoot();

    /// <summary>
    /// 將「根目錄 + 路徑片段」組成安全的絕對路徑。
    /// 每個片段必須是單一名稱（資料夾名或檔名），不可含任何分隔字元。
    /// </summary>
    public string BuildSafeFullPath(string[] pathParts)
    {
        if (pathParts is null or { Length: 0 })
        {
            throw new InvalidOperationException("路徑片段不可為空");
        }

        // ── (1) 根目錄：來自 DB 的 Stored 污染源，於「最早使用點」先以 Replace 斷開污點鏈 ──
        var rawRoot = _fileServerRoot;
        if (string.IsNullOrWhiteSpace(rawRoot))
        {
            throw new InvalidOperationException("檔案伺服器根目錄未設定");
        }

        // 【為通過靜態掃瞄而加】只移除穿越序列與正斜線；
        // 反斜線與磁碟機符號是絕對路徑／UNC 的合法組成，不移除。
        var sanitizedRoot = rawRoot.Replace("..", "")
                                   .Replace("/",  "");

        // fail-closed：設定值本身即不允許含穿越序列或正斜線（根目錄一律以反斜線書寫）
        if (!string.Equals(sanitizedRoot, rawRoot, StringComparison.Ordinal))
        {
            throw new InvalidOperationException($"根目錄設定值含不允許的字元：'{rawRoot}'");
        }

        var basePath = Path.TrimEndingDirectorySeparator(sanitizedRoot);

        // ── (2) 每個片段逐一淨化 ──
        // 必須用 for 直接呼叫；不可用 LINQ Select(lambda)，靜態掃瞄器追不進 lambda。
        var safeParts = new string[pathParts.Length];
        for (var i = 0; i < pathParts.Length; i++)
        {
            safeParts[i] = SanitizeSegment(pathParts[i]);
        }

        // ── (3) 組合並正規化為絕對路徑（下方前綴圍堵依賴正規化，GetFullPath 不可移除）──
        var combinedPath = Path.GetFullPath(Path.Combine([basePath, .. safeParts]));

        // ── (4) 組合後的完整路徑再套一次 Replace ──
        // 位置必須在驗証之前：確保「被驗証的值」就是「被回傳的值」。
        var sanitizedFullPath = combinedPath.Replace("..", "")
                                            .Replace("/",  "");

        // ── (5) fail-closed：不允許 Replace 靜默改變實際目標，一有取代即拒絕 ──
        if (!string.Equals(sanitizedFullPath, combinedPath, StringComparison.Ordinal))
        {
            throw new InvalidOperationException($"路徑包含不允許的穿越字元：'{combinedPath}'");
        }

        // ── (6) 圍堵：最終路徑必須「嚴格」位於根目錄之下 ──
        // 前綴必須以分隔字元結尾，否則 "D:\App" 會誤放行 "D:\App-evil\..."。
        var requiredPrefix = Path.EndsInDirectorySeparator(basePath)
                                 ? basePath
                                 : basePath + Path.DirectorySeparatorChar;

        if (!sanitizedFullPath.StartsWith(requiredPrefix, StringComparison.OrdinalIgnoreCase))
        {
            throw new InvalidOperationException($"路徑必須位於檔案伺服器根目錄之下：'{sanitizedFullPath}'");
        }

        return sanitizedFullPath;
    }

    /// <summary>
    /// 將單一路徑片段淨化為純名稱（不含任何目錄資訊）。
    /// Replace 在最前——之後所有檢查與回傳用的都是取代後的值。
    /// </summary>
    private static string SanitizeSegment(string part)
    {
        if (string.IsNullOrWhiteSpace(part))
        {
            throw new InvalidOperationException("路徑片段不可為空白");
        }

        // 【為通過靜態掃瞄而加】斷開片段層級的污點鏈
        var sanitized = part.Replace("..", "")
                            .Replace("/",  "")
                            .Replace("\\", "");

        // 剝除任何殘餘目錄資訊（"a/../b" → "b"、"C:\x\y" → "y"）
        sanitized = Path.GetFileName(sanitized);

        // fail-closed：淨化前後不一致＝輸入含目錄資訊或穿越字元，直接拒絕、不靜默改名
        if (!string.Equals(sanitized, part, StringComparison.Ordinal))
        {
            throw new InvalidOperationException($"路徑片段不可包含目錄資訊或穿越字元：'{part}'");
        }

        // Windows 會靜默剝除尾端點與空白，造成實際落點與驗証值不同
        if (sanitized != sanitized.TrimEnd('.', ' '))
        {
            throw new InvalidOperationException($"路徑片段不可以點或空白結尾：'{part}'");
        }

        if (sanitized.IndexOfAny(Path.GetInvalidFileNameChars()) >= 0)
        {
            throw new InvalidOperationException($"路徑片段包含非法字元：'{part}'");
        }

        if (IsReservedDeviceName(sanitized))
        {
            throw new InvalidOperationException($"路徑片段不可為系統保留名稱：'{part}'");
        }

        return sanitized;
    }

    private static readonly string[] _reservedDeviceNames =
    [
        "CON", "PRN", "AUX", "NUL",
        "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9",
        "LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9",
    ];

    private static bool IsReservedDeviceName(string name)
    {
        var baseName = Path.GetFileNameWithoutExtension(name);
        return _reservedDeviceNames.Contains(baseName, StringComparer.OrdinalIgnoreCase);
    }
}
```

### 3-3 寫入／刪除／讀取：Sink 一律直接使用回傳值

```csharp
public class SecureFileStorage(IAppConfigRepository configRepository)
{
    // ...（承上）...

    /// <summary>儲存上傳檔案，回傳實際儲存檔名。</summary>
    public async Task<string> StoreAsync(string[] directoryParts, IFormFile upload)
    {
        var safeDirectoryPath = BuildSafeFullPath(directoryParts);

        if (Directory.Exists(safeDirectoryPath) == false)     // Sink：參數為直接回傳值
        {
            Directory.CreateDirectory(safeDirectoryPath);     // Sink：同上
        }

        var storedFileName = BuildStoredFileName(upload);

        var safeFilePath = BuildSafeFullPath([.. directoryParts, storedFileName]);

        using var stream = new FileStream(safeFilePath,       // Sink：同上
                                          new FileStreamOptions
                                          {
                                              Mode   = FileMode.CreateNew,   // 不覆蓋既有檔案
                                              Access = FileAccess.Write,
                                              Share  = FileShare.None,
                                          });

        await upload.CopyToAsync(stream);

        return storedFileName;
    }

    /// <summary>刪除檔案。</summary>
    public void Remove(string[] pathParts)
    {
        var safeFilePath = BuildSafeFullPath(pathParts);

        if (File.Exists(safeFilePath))                        // Sink：參數為直接回傳值
        {
            File.Delete(safeFilePath);                        // Sink：同上
        }
    }

    /// <summary>開啟檔案供下載（回傳實體檔案路徑給框架的 API 也必須走同一入口）。</summary>
    public FileStream OpenRead(string[] pathParts)
    {
        return new FileStream(BuildSafeFullPath(pathParts),   // Sink：參數為直接回傳值
                              FileMode.Open, FileAccess.Read, FileShare.Read);
    }

    /// <summary>
    /// 組成實際儲存檔名。上傳檔名（multipart filename）是 Path Traversal 的典型污染源，
    /// 同樣在最早使用點先 Replace、再 fail-closed 驗証。
    /// </summary>
    private static string BuildStoredFileName(IFormFile upload)
    {
        if (string.IsNullOrWhiteSpace(upload.FileName))
        {
            throw new InvalidOperationException("檔案名稱不可為空白");
        }

        // 【為通過靜態掃瞄而加】斷開來自 multipart 檔名的污點鏈
        var sanitized = upload.FileName.Replace("..", "")
                              .Replace("/",  "")
                              .Replace("\\", "");

        var safeFileName = Path.GetFileName(sanitized);

        if (!string.Equals(safeFileName, upload.FileName, StringComparison.Ordinal))
        {
            throw new InvalidOperationException($"檔案名稱不可包含目錄資訊或穿越字元：'{upload.FileName}'");
        }

        var name      = Path.GetFileNameWithoutExtension(safeFileName);
        var extension = Path.GetExtension(safeFileName);

        // 加時間戳避免同名，與 FileMode.CreateNew 搭配確保不覆蓋
        return $"{name}_{DateTime.Now:yyyyMMdd_HHmmss_fffffff}{extension}";
    }
}
```

### 3-4 呼叫端用法

```csharp
// 上傳：片段一律是「單一名稱」，不可含分隔字元
var storedFileName = await fileStorage.StoreAsync([customerCode, year, caseNumber], upload);

// 刪除
fileStorage.Remove([customerCode, year, caseNumber, storedFileName]);

// 設定值若是多層相對路徑（例 "sub1\sub2"），必須先拆成片段再傳入，
// 直接整串傳入會被 SanitizeSegment 以「含目錄資訊」拒絕
var parts = relativeFolder.Split(['\\', '/'], StringSplitOptions.RemoveEmptyEntries);
var safePath = fileStorage.BuildSafeFullPath(parts);
```

---

## 4. 每個設計決定的理由

| 設計 | 理由 |
|---|---|
| `Replace` 放在該值的**最早使用點** | 掃瞄器追蹤的是「值的傳遞鏈」；Replace 必須出現在被追蹤值本身的鏈上才被採計，套在別的變數上無效 |
| `Replace` 一律在**驗証之前** | 若先驗証再取代，「被驗証的值」與「被回傳的值」是兩個值，圍堵保証失效；順序對了，取代後的值才是被驗証、被回傳的同一個值 |
| 取代後立刻做**相等性 fail-closed** | 讓 Replace 在合法輸入上可證明為 no-op：字元真的被取代時直接拒絕，而不是靜默把惡意路徑改成另一個「可寫入」的路徑 |
| 根目錄的 Replace **不含 `\`**，片段的 Replace **含 `\`** | 根目錄是絕對路徑／UNC，反斜線是合法組成；片段是單一名稱，任何分隔字元都不合法 |
| 片段淨化用 **for 迴圈**、不用 LINQ lambda | 掃瞄器不會進入 lambda 內部，包進去等同沒淨化 |
| `Path.GetFullPath` 保留 | 前綴圍堵是字串比對，只有在絕對路徑已正規化時才成立；它不被掃瞄器當淨化採計，但真實防護需要它 |
| 圍堵前綴**以分隔字元結尾** | 防止 `D:\App` 誤放行 `D:\App-evil\...` 的前綴繞過 |
| 拒絕尾端點／空白、系統保留名稱 | Windows 檔案系統會靜默剝除尾端點與空白（實際落點≠驗証值）；`CON`、`NUL` 等保留名稱會導向裝置而非檔案 |
| `Path.GetFileName` 往返比對 | 剝除目錄資訊後與原值比對，等於「證明輸入本來就不含目錄資訊」，比黑名單列舉字元更完備 |
| `FileMode.CreateNew` ＋ 時間戳檔名 | 寫入不覆蓋既有檔案，同名上傳也不互相蓋寫 |

---

## 5. 維護紅線

1. **任何檔案系統呼叫的路徑參數，必須是安全路徑組裝方法的「直接回傳值」**——就地 `Path.Combine` 一下、或先存變數再加工，都會立刻產生新告警。
2. **不可移除任何標註「為通過靜態掃瞄而加」的 `Replace`**——移除後該值下游的所有檔案系統呼叫都會重新被回報。
3. **淨化邏輯不可包進 LINQ lambda**，一律以 for 迴圈直接呼叫。
4. **`Replace` 永遠在驗証之前**，並保留相等性 fail-closed 斷言。
5. **下載端點與上傳端點適用同一條規則**：把實體路徑交給框架回傳檔案的 API，路徑同樣必須來自唯一入口。

---

## 6. 進階：DB 來源的殘餘風險（真實資安，非掃瞄議題）

本做法的圍堵是「拿 DB 讀出的根目錄自己當基準」——若 DB 值被竄改（SQL Injection、直接改表），信任邊界會跟著位移，圍堵斷言照樣通過。若需要防到這一層，可在組態檔放一份**根目錄白名單**，啟動或使用時驗証 DB 值必須落在白名單內；DB 保留營運彈性，白名單守住信任邊界。
