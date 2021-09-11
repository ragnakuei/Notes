# 設定 RequestBody 容量限制

超過時，會發出 `BadHttpRequestException`
其 Message 為 `Request body too large.`

## 透過 Attribute

可以透過 `RequestSizeLimit` 來設定

```csharp
[RequestSizeLimit(1000)]
[HttpPost, Route("api/[Controller]/[Action]")]
[ValidateAntiForgeryToken]
public async Task<IActionResult> UploadImage(SingleImageFileFormDto file)
{
    // ..
}
```

## 透過 Startup.ConfigureService() 設定

```csharp
services.Configure<KestrelServerOptions>(options =>
                                         {
                                            options.Limits.MaxRequestBodySize = 1000;
                                         });
```
