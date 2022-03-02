# 設定 request timeout

### asp.net core 6 之後

```cs
builder.WebHost.UseKestrel(options =>
{
    options.Limits.RequestHeadersTimeout = TimeSpan.FromMinutes(60);
    options.Limits.KeepAliveTimeout = TimeSpan.FromMinutes(60);
});
```