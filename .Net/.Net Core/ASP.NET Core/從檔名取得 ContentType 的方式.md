# 從檔名取得 ContentType 的方式

```csharp
var provider = new FileExtensionContentTypeProvider();
string contentType;
if(!provider.TryGetContentType(fileName, out contentType))
{
    contentType = "application/octet-stream";
}
return contentType;
```
