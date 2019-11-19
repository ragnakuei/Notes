# 以 Stream 寫入檔案

二種方式：

## 方式一

```csharp
var fileStream = File.Create("C:\\Path\\To\\File");
_stream.Seek(0, SeekOrigin.Begin);
_stream.CopyTo(fileStream);
fileStream.Close();
```

## 方式二

```csharp
using (var fileStream = File.Create("C:\\Path\\To\\File"))
{
    _stream.Seek(0, SeekOrigin.Begin);
    _stream.CopyTo(fileStream);
}
```
