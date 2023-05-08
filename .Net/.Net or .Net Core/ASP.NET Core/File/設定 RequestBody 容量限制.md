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

## Kestrel 設定

```csharp
services.Configure<KestrelServerOptions>(options =>
                                         {
                                            options.Limits.MaxRequestBodySize = 1000;
                                         });
```

或

```cs
var maxRequestSize = 1024 * 1024 * 100;
builder.WebHost.ConfigureKestrel(serverOptions =>
                                {
                                    serverOptions.Limits.MaxRequestBodySize = maxRequestSize;
                                });
```
