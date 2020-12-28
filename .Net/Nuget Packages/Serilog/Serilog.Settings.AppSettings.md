# [Serilog.Settings.AppSettings](https://github.com/serilog/serilog-settings-appsettings)

讀取 web.config > appsettings 設定的套件

```csharp
Log.Logger = new LoggerConfiguration()
            .ReadFrom.AppSettings() // 套件 Serilog.Settings.AppSettings
            .CreateLogger();
```
