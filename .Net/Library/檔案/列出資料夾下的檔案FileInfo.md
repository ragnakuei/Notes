# 列出資料夾下的檔案 FileInfo

```csharp
var files = Directory.GetFiles(@"C:\Intel\Logs");
foreach (var f in files)
{
	var fileInfo = new FileInfo(f);
	fileInfo.Name.Dump();
	fileInfo.FullName.Dump();
}
```
