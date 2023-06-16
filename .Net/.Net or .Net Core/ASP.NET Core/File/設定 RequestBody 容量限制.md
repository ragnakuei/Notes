# 設定 RequestBody 容量限制

[Server and app configuration](https://docs.microsoft.com/zh-tw/aspnet/core/mvc/models/file-uploads#server-and-app-configuration)

[Upload large files with streaming](https://docs.microsoft.com/zh-tw/aspnet/core/mvc/models/file-uploads#upload-large-files-with-streaming)


## Kestrel 設定

超過時，會發出 `BadHttpRequestException`
其 Message 為 `Request body too large.`

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

## 針對 FormData

前置
- 要設定 Kestrel 的 `Limits.MaxRequestBodySize`，才會生效

超過時，不會發生 global exception
從 Log 中，只會看到
- The request has model state errors, returning an error response. 
- Executing BadRequestObjectResult,
而看不出實際原因


單一設定
- 放在 Action 上

```cs
[RequestFormLimits(MultipartBodyLengthLimit = 2147483648)]
```

全域設定

```cs
services.Configure<FormOptions>(options =>
{
    // 預設值為 128 MB
    // Set the limit to 256 MB
    options.MultipartBodyLengthLimit = 268435456;
});
```


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