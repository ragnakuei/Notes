# CORS 設定方式

[參考資料](https://docs.microsoft.com/zh-tw/aspnet/core/security/cors)

注意：設定 Cors 後，可能會讓 error response message 都變成 cors 沒過的訊息，但實際上是別的問題。可用 Log 來釐清 !

## 全域設定方式

Startup.cs

```csharp
private readonly string _frontEndSiteName = "Vue";

public void ConfigureServices(IServiceCollection services)
{
    services.AddCors(options =>
                        {
                            options.AddPolicy(_frontEndSiteName,
                                            builder =>
                                            {
                                                builder.WithOrigins("http://localhost:8080")
                                                       .AllowAnyMethod()
                                                       .AllowAnyHeader();
                                            });
                        });
    services.ConfigDiContainer(Configuration);
}

public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    app.UseCors(_frontEndSiteName);
}
```

## 部份套用方式

在設定好後

```csharp
services.AddCors(options =>
    {
        options.AddPolicy("Policy1", builder.....
    }));
```

不在 Configure() 中套用

```csharp
 app.UseCors();
```

在指定的 Controller / Action 上加上指定的 CORS Policy 名稱，就可以了 !

```csharp
[EnableCors("Policy1")]
```
