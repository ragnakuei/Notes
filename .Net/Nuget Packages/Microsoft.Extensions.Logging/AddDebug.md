# [AddDebug](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/#debug)

- Debug 組態已內建
- Release 組態預設不會 Log Diagnostics 的訊息

```cs
public static void Main(string[] args)
{
    var processPath    = AppDomain.CurrentDomain.BaseDirectory;
    var nlogConfigPath = Path.Combine(processPath, "3rd Party", "NLog", "nlog.config");
    var log            = NLogBuilder.ConfigureNLog(nlogConfigPath).GetCurrentClassLogger();

    Host.CreateDefaultBuilder(args)
        .ConfigureLogging((context, logging) =>
                            {
                                logging.ClearProviders();
#if DEBUG
                                // logging.AddConsole();
#endif
                                // 在 Release 組態下，就設置 Debug Level 為 Debug ，仍然看不到 
                                logging.AddDebug();

                                logging.AddNLog();
                            })
        .ConfigureWebHostDefaults(webBuilder =>
                                    {
                                        webBuilder.UseStartup<Startup>();
                                    })
        .Build()
        .Run();
}
```