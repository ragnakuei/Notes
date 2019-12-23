# CORS 設定方式

Startup.cs

```csharp
private readonly string _frontEndSite = "http://localhost:4200";

public void ConfigureServices(IServiceCollection services)
{

    services.AddCors(options =>
    {
        options.AddPolicy(_frontEndSite,
        builder =>
        {
            builder.WithOrigins("http://example.com",
                                "http://www.contoso.com");
        });
    });
}

public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    app.UseCors(_frontEndSite);
}
```

[參考資料](https://docs.microsoft.com/zh-tw/aspnet/core/security/cors)
