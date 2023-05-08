# CORS 設定方式

[參考資料](https://docs.microsoft.com/zh-tw/aspnet/core/security/cors)

注意：設定 Cors 後，可能會讓 error response message 都變成 cors 沒過的訊息，但實際上是別的問題。可用 Log 來釐清 !

## 全域設定方式

- 只打開 Origin 的話，會讓所有的 Method 都可以存取，但是無法讓 Content-Type: application/json 的 POST 存取

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
                                                    //    .WithHeaders("Content-Type");
                                                    
                                                    // 額外開放 Content-Type: application/json 的 POST 存取
                                                    .WithMethods("POST")
                                                    .WithHeaders("Content-Type")      // 實際上無法只開放 Content-Type: application/json，只能開放全部

                                                    //    .AllowAnyMethod()
                                                    //    .AllowAnyHeader()
                                                    ;
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




## Debug 方式

如果不知道缺少哪些設定，可以看 Chrome Console 的錯誤訊息

例：

```
cess to fetch at 'https://localhost:7120/weatherforecast' from origin 'http://127.0.0.1:5501' has been blocked by CORS policy: Request header field content-type is not allowed by Access-Control-Allow-Headers in preflight response.
```

其中就提示說 header 的部份缺少 content-type