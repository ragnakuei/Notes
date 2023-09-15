# 不加上 Kestrel Server Header

```cs
var builder = WebApplication.CreateBuilder(args);

// 移除 Response Header > Server 
builder.WebHost.UseKestrel(option => option.AddServerHeader = false);
```


```csharp
public static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)
        .ConfigureWebHostDefaults(webBuilder =>
                                    {
                                        // 加上這一段
                                        webBuilder.ConfigureKestrel(serverOptions =>
                                                                    {
                                                                        serverOptions.AddServerHeader = false;
                                                                    });
                                        webBuilder.UseStartup<Startup>();
                                    });
```
