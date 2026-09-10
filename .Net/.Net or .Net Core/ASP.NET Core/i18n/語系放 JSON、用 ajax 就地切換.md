# 語系放 JSON、用 ajax 就地切換

`D:\Demo\repos\Asp.Net Core i18n` 的作法整理。ASP.NET Core 8.0 MVC，一個題目兩件事：

1. **語系字串放 JSON**（`Resources/<語系>.json`，一個語系一份），
   由自寫的 `IStringLocalizerFactory` / `IStringLocalizer` 供應，合併後的結果快取在 `IMemoryCache`
2. **語系用 ajax 切換**，切換之後畫面就地換字，**不重新整理、也不導頁**

同資料夾的 [IStringLocalizer](./IStringLocalizer.md)、[AddLocalization](./AddLocalization.md)、
[設定 RequestLocalizationOptions](./設定%20RequestLocalizationOptions.md) 是框架內建那一套；
這一份是**整套自己接**的版本。

> 更早的一版用的是另一套作法：`/zh-tw/home/index` 這種語系路由前綴 +
> `Index.zh-tw.cshtml` 這種一個語系一份的檢視（repo 的 commit `38c099b`）。
> 那一版整份被這一版取代。

---

## 一句話：供應鏈路

**Repository 讀檔 → Service 合併與快取 → JsonStringLocalizer 轉成框架介面 → View 用 `@Localizer[key]`**

| 檔案 | 負責 |
|---|---|
| `Repositories/LocalizationRepository.cs` | 讀 JSON、列出有哪些語系、給出檔案的 `IChangeToken` |
| `Services/Localization/Service.cs` | 合併退回鏈、快取、切換語系的流程 |
| `Services/Localization/ValidateDtoService.cs` | 白名單驗証 |
| `Utilities/Infra/JsonStringLocalizer.cs` | 把 Service 的結果包成 `LocalizedString` |
| `Utilities/Infra/JsonStringLocalizerFactory.cs` | 產生上面那一支 |
| `Views/Shared/_Layout.cshtml`、`wwwroot/js/shared/i18n.js` | 伺服器端渲染初值、前端就地換字 |

Repository 那一層**只做「把 JSON 讀進來」與「告訴上層檔案變了」**——不合併、不退回、不快取。
那些全在 Service。這個切法在最後一節〈Scale out〉會兌現。

---

## 註冊：不要呼叫 `AddLocalization()`

`Program.cs` 的關鍵三行：

```csharp
builder.Services.AddSingleton<IStringLocalizerFactory, JsonStringLocalizerFactory>();
builder.Services.AddSingleton(typeof(IStringLocalizer<>), typeof(StringLocalizer<>));
builder.Services.AddSingleton<IStringLocalizer>(sp => sp.GetRequiredService<IStringLocalizerFactory>()
                                                       .Create(typeof(Program)));
```

**刻意不呼叫 `AddLocalization()`**：那一支註冊的是讀 `.resx` 的
`ResourceManagerStringLocalizerFactory`，註冊順序稍有不同就會蓋來蓋去，
而且會讓人以為專案裡真的有 `.resx`。需要的兩件事在上面各自明寫：

| 這一行 | 給誰用 |
|---|---|
| `IStringLocalizerFactory` → 自己的工廠 | 整套的入口 |
| `IStringLocalizer<>` → 框架的 `StringLocalizer<T>` | Controller / Service 的 `IStringLocalizer<T>`；它自己會轉呼工廠 |
| 非泛型 `IStringLocalizer` | View 的 `@inject IStringLocalizer Localizer`（寫在 `_ViewImports.cshtml`） |

`RequestLocalizationOptions` 照樣用框架的，支援清單直接由資源資料夾決定：

```csharp
var supportedCultures = localizationService.GetCultureNames()
                                           .Select(name => new CultureInfo(name))
                                           .ToList();

app.UseRequestLocalization(new RequestLocalizationOptions
                           {
                               DefaultRequestCulture = new RequestCulture(CultureConsts.DefaultCulture),
                               SupportedCultures     = supportedCultures,
                               SupportedUICultures   = supportedCultures,
                           });
```

### `Create()` 刻意忽略型別與 baseName

```csharp
public class JsonStringLocalizerFactory(IService service) : IStringLocalizerFactory
{
    private readonly JsonStringLocalizer _localizer = new(service);

    public IStringLocalizer Create(Type resourceSource)              => _localizer;
    public IStringLocalizer Create(string baseName, string location) => _localizer;
}
```

`.resx` 是**一個型別一份**資源，所以 `Create(Type)` 才有意義。
這裡是**一個語系一份**，鍵值在整站唯一，兩個多載因此回傳同一個實體。

代價是所有鍵值共用一個命名空間，所以**鍵值一律以「頁面.用途」命名**：
`Home.Title`、`Layout.Nav.About`、`About.Cache.Body`。

### localizer 只是個轉接頭

`JsonStringLocalizer` 裡沒有任何邏輯——查字串、合併、快取全在 Service。
理由是 `IStringLocalizer` 是**框架的介面**：它規定了 `this[name]` 與 `GetAllStrings()` 這種形狀，
卻沒有地方放「語系清單」「切換」「驗証」。把邏輯放進 localizer，
切換語系那條路（Controller → Service）就得繞回框架介面拿資料，
變成上層依賴一個為了別的用途而設計的介面。

兩個實作上的細節：

- **查的是呼叫當下的 `CultureInfo.CurrentUICulture`**，不是建構時的。
  這個物件是 Singleton，建構時記下語系的話，**全站會鎖在第一個請求的語系上**。
- **查不到就回傳鍵值本身**（畫面上看到 `Home.Title` 這種字串），並標 `resourceNotFound: true`。
  漏翻要看得出來，不是留一塊空白讓人以為版面壞了。

---

## 缺字串的退回順序

```
en-US（DefaultCulture） → 中性語系（zh-TW 的 zh） → 指定語系
```

**後面的蓋掉前面的**。順序反過來寫（指定語系先、預設語系後）會讓翻譯到一半的語系被英文蓋掉，
而且錯得很安靜——畫面照樣有字，只是全是英文。

再退不到就回傳鍵值本身（見上一節）。

`Resources/en-US.json` 因此是**唯一必須存在、而且必須有全部鍵值**的資源檔。

---

## ★ 改了 JSON 就重讀：`ICacheEntry` + `IChangeToken`

整個機制的接點只有一行：**`ICacheEntry.AddExpirationToken()`**。
`IMemoryCache` 本身不認識檔案，它只認識「到期條件」；
檔案監看是被包成一個 `IChangeToken` 掛到那個條件上的。

### ① 拿到 `ICacheEntry`

```csharp
var texts = memoryCache.GetOrCreate(cacheKey, entry => BuildTexts(entry, cultureName));
```

`GetOrCreate` 的 factory 簽章是 `Func<ICacheEntry, TItem>`——**這是拿到 `ICacheEntry` 的唯一途徑**。
它的實作大致是：

```csharp
if (!cache.TryGetValue(key, out var result))
{
    using ICacheEntry entry = cache.CreateEntry(key);   // 建立一筆「還沒送進快取」的項目
    result      = factory(entry);                       // 我們的 BuildTexts 在這裡執行
    entry.Value = result;
}                                                       // Dispose 才真正寫進快取並掛上到期條件
```

**`ICacheEntry` 是「這一筆的設定面板」**，而且是在 `Dispose()` 那一刻才連同設定 commit 進 `MemoryCache`。
面板上有 `AbsoluteExpiration`、`SlidingExpiration`、`Size`、`PostEvictionCallbacks`、`ExpirationTokens`；
這個作法**一個時間類的都沒設**，只設了最後一項。

### ② 把每個來源檔的監看掛上去

```csharp
private Dictionary<string, string> BuildTexts(ICacheEntry entry, string cultureName)
{
    var texts = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);

    foreach (var fallbackCultureName in GetFallbackChain(cultureName))
    {
        entry.AddExpirationToken(repository.Watch(fallbackCultureName));   // ★ 接點

        foreach (var pair in repository.GetResource(fallbackCultureName))
        {
            texts[pair.Key] = pair.Value;
        }
    }

    return texts;
}
```

一筆快取可以掛**多個** token，**任何一個觸發就整筆失效**。
`zh-TW` 這一筆掛的是 `en-US.json` 與 `zh-TW.json` 兩個——因為它的內容是兩個檔合併出來的。

### ③ token 從哪來

```csharp
public IChangeToken Watch(string cultureName)
{
    return environment.ContentRootFileProvider.Watch(GetRelativePath(cultureName));
}
```

`PhysicalFileProvider.Watch("Resources/zh-TW.json")` 回一個 `IChangeToken`，
底下是一個掛在 `Resources` **目錄**上的 `FileSystemWatcher`——
不是掛在單一檔案上，所以**檔案還不存在也監看得到**，之後補上去照樣觸發。

> 讀檔與監看**一律走同一個 `ContentRootFileProvider`**，不自己用 `File.ReadAllText` 拼絕對路徑：
> 同一個 provider 既讀得到檔案、又給得出 token，兩者看的是同一份檔案，
> 不會出現「讀的是 A、監看的是 B」這種對不起來的情況。

### 一次完整的來回

| # | 發生什麼 | 誰做的 |
|---|---|---|
| 1 | 第一個請求要 `zh-TW` 的字串，快取沒有 | `GetOrCreate` → `TryGetValue` 失敗 |
| 2 | 建立 `ICacheEntry`，交給 `BuildTexts` | `cache.CreateEntry(key)` |
| 3 | 讀兩個 JSON 合併，並把兩個 `IChangeToken` 掛上 entry | `BuildTexts` |
| 4 | factory 回傳，`entry.Dispose()` → 寫進快取，**同時對每個 token 註冊回呼** | `MemoryCache` |
| 5 | 之後的請求都直接命中快取，**不碰磁碟** | `TryGetValue` |
| 6 | 有人存檔改了 `zh-TW.json` | 開發者 |
| 7 | `FileSystemWatcher` 事件 → token 觸發 → 回呼被叫到 → 那一筆以 `EvictionReason.TokenExpired` 逐出 | `PhysicalFilesWatcher` + `MemoryCache` |
| 8 | **這裡什麼都沒有重讀**，快取只是空了 | — |
| 9 | 下一個請求進來，回到第 1 步，重新讀檔 | `GetOrCreate` |

第 8 步是關鍵：**逐出是被動的，重讀發生在「下一次有人要」**。
所以操作是「存檔 → 重新整理瀏覽器」，不是「存檔 → 等它自己更新畫面」。

### ★ 三個容易寫錯的地方

**1. `Watch()` 一定要在 factory 裡面呼叫，不能自己存起來重用。**

`PhysicalFilesWatcher` 對同一個 pattern，在**還沒觸發之前**回的是同一個 token 實體；
一旦觸發，那個 token 的 `HasChanged` 就**永遠是 true**，它會被丟掉，下次 `Watch()` 才給你一個新的。
把 token 存成欄位重用的話，重建的那一筆會帶著一個已經觸發的 token——
`MemoryCache` 在 commit 時就判定它過期，**這筆等於從來沒進過快取**，
之後每個請求都重讀磁碟，**而且完全不會報錯**。

**2. 掛的必須是整條退回鏈。**

只掛 `zh-TW.json` 的話，改 `en-US.json` 之後 `zh-TW` 那一筆不會失效，
它會繼續用舊的英文退回值——**只有那幾個「還沒翻譯」的鍵值是舊的**，最難發現的那一種。

**3. 沒有設任何時間到期是刻意的。**

這一筆的唯一到期條件就是「來源檔變了」。設 `SlidingExpiration` 只會讓沒人存取時白白重讀一次；
設 `AbsoluteExpiration` 則是在「檔案沒變也照樣重讀」與「檔案變了要等時間到」之間兩頭不討好。
檔案不變 = 永遠命中（除非行程重啟或記憶體壓力把它擠掉，那也只是重讀一次）。

**還有一件事是合併的時機**：**合併後才快取**，不是快取每個檔再逐次合併。
查一個字串是每個請求都會做好幾次的事，留在讀取路徑上的合併就會做好幾次。

### 監看不到事件的環境

`FileSystemWatcher` 在某些檔案系統上收不到事件（容器掛載、部分網路磁碟機）。
那時設環境變數 **`DOTNET_USE_POLLING_FILE_WATCHER=1`**，`PhysicalFileProvider` 會改用
每 4 秒輪詢比對時間戳——**程式碼一行都不用改**，因為整條鏈路只認 `IChangeToken`，
不認它底下是 watcher 還是輪詢。

也因此**不需要「手動重新載入」的按鈕或 API**。

> 監看的是 **ContentRoot 底下的 `Resources/`**。`dotnet run` 與 IDE 的 F5 都把 ContentRoot
> 指在專案目錄，所以改的就是原始檔；直接執行 `bin\Debug\net8.0\*.exe` 則會讀到複製過去的那一份副本，
> 改原始檔怎麼樣都不會生效——**「改了沒反應」最常見的原因是這個，不是監看壞掉。**

---

## 語系清單是啟動時定案的，跟快取不是同一件事

```csharp
private readonly IReadOnlyList<string> _cultureNames = repository.GetCultureNames();
```

Service 建構時讀一次就不再變，**沒有掛監看**。理由是
`RequestLocalizationOptions.SupportedUICultures` 在建立管線時就固定了：
清單若會自己長出新語系，選單就會出現一個 middleware 根本不接受的語系——
使用者切過去，畫面卻退回預設語系，**而且不會有任何錯誤訊息**。

| 動作 | 要不要重啟 |
|---|---|
| 改資源檔的**內容** | 不用，走上面那套快取失效 |
| **新增**一個語系檔 | **要重啟** |

Service 註冊成 **Singleton**：它沒有任何跟請求有關的狀態——「現在是哪個語系」每次都從
`CultureInfo.CurrentUICulture` 讀，那是 `RequestLocalizationMiddleware` 依 Cookie 設好的，
跟著 async 執行流程走，不會因為服務是單例而互相污染。
反過來說，快取的內容本來就該讓所有請求共用，掛在 Scoped 上等於每個請求都重讀一次檔案。

---

## 切換語系的前後端約定

| 端點 | 用途 |
|---|---|
| `POST /api/Culture/GetCultures` | 語系清單（`Name` / `DisplayName` / `IsCurrent`） |
| `POST /api/Culture/GetTexts` | 目前語系的所有字串 |
| `POST /api/Culture/Switch` | 切換，回傳切換後的語系**與整包字串** |

**`Switch` 一併回字串是整個設計的關鍵**：前端拿到就能就地換字，不必再問一次，也不必重新整理。

三支都是 POST + `ValidateAntiForgeryToken`，全程 ajax，
所以不需要「送出表單再導回原頁」那種 POST-Redirect-GET 的進入點。

### Cookie 由 Controller 寫，Service 不碰 `HttpContext`

```csharp
var cookieValue = CookieRequestCultureProvider.MakeCookieValue(new RequestCulture(cultureName));

Response.Cookies.Append(CookieRequestCultureProvider.DefaultCookieName,
                        cookieValue,
                        new CookieOptions
                        {
                            Expires     = DateTimeOffset.UtcNow.AddYears(1),
                            IsEssential = true,
                            HttpOnly    = true,
                            SameSite    = SameSiteMode.Lax,
                            Secure      = Request.IsHttps,
                            Path        = "/",
                        });
```

**名稱與內容格式一律用 `CookieRequestCultureProvider` 的**，不要自己拼字串：
格式一改（`c=zh-TW|uic=zh-TW` 這個形狀）就會**安靜地失效**，變成每次重新整理都跳回預設語系。

`HttpOnly = true`：這個值只有伺服器端的 `RequestLocalizationMiddleware` 在讀，
前端拿到的語系來自切換 API 的回應，不必也不該從 Cookie 讀。

### ★ View 的兩件事要一起做

```html
<h1 data-i18n="Home.Title">@Localizer["Home.Title"]</h1>
```

| 少了哪一個 | 症狀 |
|---|---|
| 少 `@Localizer[...]` | **第一次載入會先閃一下英文**（等 ajax 回來才變） |
| 少 `data-i18n` | **切換語系之後那一段不會變** |

其餘幾個標記：

| 標記 | 用在 |
|---|---|
| `data-i18n-args` | 字串裡有 `{0}` 時帶格式化引數（值是 JSON 陣列），對應 C# 的 `Localizer[key, args]` |
| `data-i18n-placeholder` | 寫在 attribute 上的文字沒有 `textContent` 可換 |
| `data-culture-name` | 顯示語系代號的節點 |
| `<body data-i18n-title="...">` | 瀏覽器分頁的標題，它不在頁面的節點上 |

### 前端：`applyCulture( culture, texts )`

`wwwroot/js/shared/i18n.js` 收到一整包字串之後做四件事，
然後在 `document` 上派送 `CULTURE_CHANGED_EVENT`：

```javascript
export const applyCulture = ( culture, texts ) => {

    document.documentElement.lang = culture;

    applyTextContent( texts );      // [data-i18n]
    applyPlaceholder( texts );      // [data-i18n-placeholder]
    applyCultureName( culture );    // [data-culture-name]
    applyDocumentTitle( texts );    // body 的 data-i18n-title

    document.dispatchEvent( new CustomEvent( CULTURE_CHANGED_EVENT, {
        detail: { culture: culture, texts: texts },
    } ) );
}
```

兩個「不要換成空白」的細節：

- 某個鍵值在這一包裡不存在 → **留著原本的字**，不要換成空字串
- `{0}` 沒有對應引數 → **原樣留著 `{0}`**；換成空字串的話，
  漏傳引數會變成一句少了一塊的句子，而畫面上看不出少的是什麼

### 動態繪出的內容要自己接事件

由 JS 產生的節點（例如切換後才重畫的表格）**不在 `data-i18n` 的涵蓋範圍內**——
那些節點是換語系之後才產生的——所以各頁面自己接 `CULTURE_CHANGED_EVENT` 重畫一次。

### 語系選單本身

`<wc-culture-switcher>` 是個 Web Component，只負責那顆 `<select>`：
`connectedCallback` 打 `GetCultures` 繪出選項，`change` 時打 `Switch`、
拿回應餵給 `applyCulture()`。

**旁邊的標籤文字由伺服器端渲染**，不由元件產生——這樣第一次載入就有字，不會等 ajax 回來才出現。

---

## 安全性：語系名稱會變成檔名

語系名稱一路從請求走到 `Resources/{culture}.json` 這個路徑上，因此有**兩道關卡**：

| # | 在哪 | 擋什麼 |
|---|---|---|
| 1 | `ValidateDtoService.Switch()` | 比對白名單（資源資料夾裡真的有的那幾個） |
| 2 | `LocalizationRepository.GetRelativePath()` | 再比對一次形狀：`^[A-Za-z]{2,8}(-[A-Za-z0-9]{2,8})*$` |

第 2 道不是多餘的：**之後若有人從別的入口呼叫這支 Repository，它仍然擋得住** `../` 這種穿越。

白名單比對過之後，還要**換成白名單裡那一個的原始大小寫**再拿去組檔名與寫 Cookie：

```csharp
var cultureName = cultureNames.First(name => string.Equals(name,
                                                           dto!.Culture,
                                                           StringComparison.OrdinalIgnoreCase));
```

驗証服務**不碰 Repository**，白名單由呼叫端查好傳進來：
驗証服務一旦自己去讀資源資料夾，就從「不碰檔案系統也能完整測」變成必須 mock 才測得動，
而且同一份清單會被讀兩次。

---

## Scale out 的時候

**問題：多台機器的時候，把 `IMemoryCache` 換成 Redis 是不是就好了？**

**不行，而且多數情況下不該換。** 三個層次各有各的理由：

### 1. 介面層面：`IDistributedCache` 沒有「到期 token」這種東西

上面整套機制掛在 `ICacheEntry.AddExpirationToken(IChangeToken)` 上，那是 **`IMemoryCache` 專屬的**。
`IDistributedCache` 只有 `Get / Set / Refresh / Remove` + `DistributedCacheEntryOptions`，
而後者**只有絕對到期與滑動到期，沒有 token、沒有逐出回呼**，值也只是 `byte[]`。
換過去之後「檔案變了就失效」直接消失，只剩「N 秒後過期」——那正是上面說不要的東西。

### 2. 語意層面：監看是**每個行程**自己的

`FileSystemWatcher` 看的是**這台機器上的**檔案。就算自己刻一套把 token 接上 Redis，
A 節點的 watcher 也不會知道 B 節點的檔案被改了——而在 scale out 的部署裡，
每個節點各有一份自己的 `Resources/`（跟著建置產物一起佈署）。

### 3. 需求層面：語系字串根本不該進 Redis

| | 語系字串 | 適合放 Redis 的東西 |
|---|---|---|
| 誰會改它 | 佈署才會改 | 執行期間隨時會改 |
| 需不需要跨節點一致 | 不需要，每個節點的檔案本來就一樣 | 需要 |
| 存取頻率 | 每個請求數十次（每個 `@Localizer[...]`） | 遠低於此 |
| 大小 | 幾十 KB | 不一定 |

把它放進 Redis，等於**把「查一個字串」變成一次網路往返**——一個頁面渲染就是幾十次。
**每個節點讀自己的本機檔案、放自己的行程記憶體，在 scale out 之下仍然是對的作法**，一行都不用改。

### 那什麼時候真的需要動它？

只有一種情況：**語系資料的來源從「跟著佈署的檔案」變成「執行期間會改的共用儲存」**
（例如做一個後台讓人線上改翻譯，資料落在資料庫）。那時要換的是**通知**，不是快取：

```
後台存檔 → 寫進資料庫 → 發一則 Redis pub/sub 訊息
                              ↓（每個節點都收到）
                       CancellationTokenSource.Cancel()
                              ↓
        掛在 ICacheEntry 上的 CancellationChangeToken 觸發 → 該節點的 IMemoryCache 逐出
                              ↓
                    下一個請求重讀資料庫，重新建一份
```

也就是 **Redis 當通知（L2 invalidation channel），`IMemoryCache` 仍然是那個放字串的地方**。
本文這一整套結構完全不用改：`ICacheEntry.AddExpirationToken()` 那一行還在，
只是餵給它的 token 從 `PhysicalFileProvider.Watch()` 換成 `CancellationChangeToken`，
`ILocalizationRepository` 從讀檔換成讀資料庫。
**這正是把讀檔隔離在 Repository、把快取隔離在 Service 的用處。**

> .NET 9 起另有 `HybridCache`（L1 + L2 兩層，支援 `RemoveByTagAsync` 以標籤失效）。
> 它一樣**不吃 `IChangeToken`**。

### 反過來，多節點還有一件事會擋著（跟語系無關）

**Data Protection 的金鑰環。** antiforgery token 是用本機金鑰保護的，
預設金鑰環存在各節點自己的檔案系統裡。多節點之後，A 節點發的 token 到了 B 節點驗不過，
**每個 POST 都會 CSRF 失敗**。解法是把金鑰環持久化到共用位置
（`PersistKeysToStackExchangeRedis` 或共用資料夾）並設定 `SetApplicationName`。
