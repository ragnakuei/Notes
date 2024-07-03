# 設定檔 與 appsettings.json 結合

參考資料

-   [NLog configuration with appsettings.json](https://github.com/NLog/NLog.Extensions.Logging/wiki/NLog-configuration-with-appsettings.json)

[Log Level 注意事項](./Log%20Level%20注意事項.md)

優點：

-   比 nlog.config 設定更為簡潔 !
-   可以用更簡單的方式來管理不同環境的 NLog 設定 !

---

C# 語法

```cs
using NLog;
using NLog.Extensions.Logging;
using NLog.Web;

var builder = WebApplication.CreateBuilder(args);

builder.Configuration
       .AddJsonFile("appsettings.json",
                    optional: false,
                    reloadOnChange: true)
        #if LOCAL
       .AddJsonFile("appsettings.Local.json", optional: false)
    #endif
    #if TEST
       .AddJsonFile("appsettings.Test.json", optional: false)
    #endif
    ;

var config = builder.Configuration;

LogManager.Configuration = new NLogLoggingConfiguration(config.GetSection("NLog"));
var logger = LogManager.GetCurrentClassLogger();

try
{
    builder.Host.UseNLog();

    // ...

    app.Run();
}
catch (Exception exception)
{
    logger.Error(exception, "Stopped program because of exception");
    throw;
}
finally
{
    NLog.LogManager.Shutdown();
}
```
