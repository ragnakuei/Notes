# File

- [File](#file)
  - [將字串寫入檔案](#將字串寫入檔案)
  - [從檔案一次讀出所有字串](#從檔案一次讀出所有字串)
  - [從未關閉的 Stream 寫入至 File 中](#從未關閉的-stream-寫入至-file-中)
  - [從關閉的 Stream 寫入至 File 中](#從關閉的-stream-寫入至-file-中)

## 將字串寫入檔案

```csharp
var _lastRecordFileName = "lastRecord.json";

var _lastRecordFullPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, _lastRecordFileName);

var jsonSerializerOptions = new JsonSerializerOptions
                            {
                                WriteIndented = true
                            };
var fileContent = JsonSerializer.Serialize(LastRecordDto, jsonSerializerOptions);

File.WriteAllText(_lastRecordFullPath, fileContent);
```

## 從檔案一次讀出所有字串

```csharp
var _lastRecordFileName = "lastRecord.json";

var _lastRecordFullPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, _lastRecordFileName);

var fileContent = File.ReadAllText(_lastRecordFullPath);

LastRecordDto = JsonSerializer.Deserialize<LastRecordDto>(fileContent);
```

## 從未關閉的 Stream 寫入至 File 中

```csharp
var fromFilePath = Path.Combine(@"C:\tmp\001.png");
var fromFileStream = File.Open(fromFilePath, FileMode.Open);
// fromFileStream.Close();  // 如果不使用這行，就可以直接從 Stream 寫到 Stream 中

var toFilePath = Path.Combine(@"C:\tmp\003.png");
var toFileStream = File.Create(toFilePath);
fromFileStream.Seek(0, SeekOrigin.Begin);
fromFileStream.CopyTo(toFileStream);
toFileStream.Close();
```

## 從關閉的 Stream 寫入至 File 中

- 方式一

  ```csharp
  var fromFilePath = Path.Combine(@"C:\tmp\001.png");
  var ms = new MemoryStream();
  using (var file = new FileStream(fromFilePath, FileMode.Open, FileAccess.Read))
  {
      byte[] bytes = new byte[file.Length];
      file.Read(bytes, 0, (int)file.Length);
      ms.Write(bytes, 0, (int)file.Length);
  }
  ms.Close();

  // --------------------------------------

  var toFilePath = Path.Combine(@"C:\tmp\003.png");
  var toFileStream = File.Create(toFilePath);
  ms.Seek(0, SeekOrigin.Begin);
  ms.CopyTo(toFileStream);
  ms.Close();
  toFileStream.Close();
  ```

- 方式二

  範例緣由：因為 NPOI 在產生 Excel Steam 時，會強制 Close MemoryStream

  解法：從已關閉的 MemoryStream 轉成 Array 後，再用來產生 Stream 來寫入檔案

  ```csharp
  var fromFilePath = Path.Combine(@"C:\tmp\001.png");
  var fileMemoryStream = new MemoryStream();
  using (var file = new FileStream(fromFilePath, FileMode.Open, FileAccess.Read))
  {
      byte[] bytes = new byte[file.Length];
      file.Read(bytes, 0, (int)file.Length);
      fileMemoryStream.Write(bytes, 0, (int)file.Length);
  }
  fileMemoryStream.Close();

  // ---以上因為是某個 Mehtod 會強制關閉 Stream-----------------------------------

  var toFileMemoryStream = new MemoryStream(fileMemoryStream.ToArray());

  var toFilePath = Path.Combine(@"C:\tmp\003.png");
  var toFileStream = File.Create(toFilePath);
  toFileMemoryStream.Seek(0, SeekOrigin.Begin);
  toFileMemoryStream.CopyTo(toFileStream);
  toFileMemoryStream.Close();
  toFileStream.Close();
  ```
