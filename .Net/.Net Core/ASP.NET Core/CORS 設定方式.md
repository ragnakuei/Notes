# CORS 設定方式

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
                                                builder.WithOrigins("http://localhost:8080");
                                            });
                        });
    services.ConfigDiContainer(Configuration);
}

public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
{
    app.UseCors(_frontEndSiteName);
}
```

[參考資料](https://docs.microsoft.com/zh-tw/aspnet/core/security/cors)
