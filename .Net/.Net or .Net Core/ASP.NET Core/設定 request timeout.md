# 設定 request timeout

```cs
builder.WebHost.UseKestrel(options =>
{
    options.Limits.RequestHeadersTimeout = TimeSpan.FromMinutes(60);
    options.Limits.KeepAliveTimeout = TimeSpan.FromMinutes(60);
});
```