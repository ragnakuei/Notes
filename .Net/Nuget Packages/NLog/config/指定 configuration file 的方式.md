# 指定 configuration file 的方式

### 方式一

```csharp
public static void Main(string[] args)
{
    var processPath    = AppDomain.CurrentDomain.BaseDirectory;
    var nlogConfigPath = Path.Combine(processPath, "3rd Party", "NLog", "nlog.config");
    var log            = NLogBuilder.ConfigureNLog(nlogConfigPath).GetCurrentClassLogger();

    CreateHostBuilder(args).Build().Run();
}
```

### 方式二

```csharp
NLog.LogManager.Configuration = new NLog.Config.XmlLoggingConfiguration(@"D:\Projects\AnalyticsDataCollector\AnalyticsDataCollectorConsole\bin\Debug\NLog.config", true);
```
