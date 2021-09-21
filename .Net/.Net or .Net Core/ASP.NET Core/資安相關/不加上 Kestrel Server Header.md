# 不加上 Kestrel Server Header

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
