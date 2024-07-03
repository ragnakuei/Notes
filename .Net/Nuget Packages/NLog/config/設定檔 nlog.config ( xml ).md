# 設定檔 nlog.config ( xml )

可以使用 nlog.config ( xml 格式 )，也可以以結合 appsettings.json ( json 格式 ) !

[Log Level 注意事項](./Log%20Level%20注意事項.md)

---

[nlog.config](https://github.com/NLog/NLog/wiki/Configuration-file)

路徑

-   mac os，以 / 串接
-   windows，以 \ 串接

可以用 / 做為通用的串接符號 !

---

C# 相關語法

> 如果忘記給定 builder.Host.UserNLog() ，只會有 internallog，而不會有 target 所指定的檔案 !

```cs
using NLog;
using NLog.Web;

// Early init of NLog to allow startup and exception logging, before host is built
var logger = NLog.LogManager.Setup().LoadConfigurationFromAppSettings().GetCurrentClassLogger();
logger.Debug("init main");

try
{
    var builder = WebApplication.CreateBuilder(args);
    builder.Host.UseNLog();

    // 略

    app.Run();
}
catch (Exception exception)
{
    // NLog: catch setup errors
    logger.Error(exception, "Stopped program because of exception");
    throw;
}
finally
{
    // Ensure to flush and stop internal timers/threads before application-exit (Avoid segmentation fault on Linux)
    NLog.LogManager.Shutdown();
}
```

---

相關的 attributes

autoReload
