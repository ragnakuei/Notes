# NLog

[Getting started with ASP.NET Core 3](https://github.com/NLog/NLog/wiki/Getting-started-with-ASP.NET-Core-3)

## 安裝套件

-   NLog
-   NLog.Web.AspNetCore

## 建立 nlog.config

-   設定複製至輸出資料夾

```xml
<?xml version="1.0" encoding="utf-8" ?>
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      autoReload="true"
      internalLogLevel="Info"
      internalLogFile="c:\temp\internal-nlog.txt">

    <extensions>
        <add assembly="NLog.Web.AspNetCore"/>
    </extensions>

    <targets>
        <target xsi:type="File" name="allfile" fileName=".\Logs\nlog-all-${shortdate}.log"
                layout="${longdate}|${event-properties:item=EventId_Id}|${uppercase:${level}}|${logger}|${message} ${exception:format=tostring}" />

        <target xsi:type="File" name="ownFile-web" fileName=".\Logs\nlog-own-${shortdate}.log"
                layout="${longdate}|${event-properties:item=EventId_Id}|${uppercase:${level}}|${logger}|${message} ${exception:format=tostring}|url: ${aspnet-request-url}|action: ${aspnet-mvc-action}" />
    </targets>

    <rules>
        <logger name="*" minlevel="Trace" writeTo="allfile" />

        <logger name="Microsoft.*" maxlevel="Info" final="true" />
        <logger name="*" minlevel="Trace" writeTo="ownFile-web" />
    </rules>
</nlog>

```

## Program.cs

```csharp
public static IHostBuilder CreateHostBuilder(string[] args) =>
    Host.CreateDefaultBuilder(args)

        // 設定下面幾行
        .ConfigureLogging(configureLogging =>
                            {
                                configureLogging.ClearProviders();

                                // 此項設定會被 appSettings.json 的設定所𧠃蓋
                                // configureLogging.SetMinimumLevel(LogLevel.Error);
                            })
        .UseNLog()


        .ConfigureWebHostDefaults(webBuilder =>
        {
            webBuilder.UseStartup<Startup>();
        });
}
```
