# Microsoft.Extensions.Logging

[Logging in .NET Core and ASP.NET Core](https://docs.microsoft.com/zh-tw/aspnet/core/fundamentals/logging/)

## 流程

asp.net core logging 收到 log 訊息 > 送給指定的 Provider(s) > 依照 Provider 設定內容 log message

> NLog 的設定，可以指定多個 targets

## Startup.cs 注意事項

-   Logger injection into the Startup constructor is not supported.
-   Logger injection into the Startup.ConfigureServices method signature is not supported

要在 `Startup.ConfigureServices` DI ILogger\<T> 只能透過 services.BuildServiceProvider().GetService<ILogger<Startup>>() 來取得，目前不確定會有什麼副作用 !

## [Providers](https://docs.microsoft.com/zh-tw/aspnet/core/fundamentals/logging#built-in-logging-providers)

| Provider             | Package                                          |
| -------------------- | ------------------------------------------------ |
| Console              | Microsoft.Extensions.Logging.Console             |
| Debug                | Microsoft.Extensions.Logging.Debug               |
| EventSource          | Microsoft.Extensions.Logging.EventSource         |
| EventLog             | Microsoft.Extensions.Logging.EventLog            |
| TraceSource          | Microsoft.Extensions.Logging.TraceSource         |
| AzureAppServicesFile | Microsoft.Extensions.Logging.AzureAppServices    |
| AzureAppServicesBlob | Microsoft.Extensions.Logging.AzureAppServices    |
| ApplicationInsights  | Microsoft.Extensions.Logging.ApplicationInsights |

---

## Microsoft.Extensions.Logging.Console

```csharp
var loggerFactory = LoggerFactory.Create(builder =>
{
    // 指定以 Console 做為 Provider
    builder.AddConsole();
});
ILogger logger = loggerFactory.CreateLogger<Program>();
logger.LogInformation("Example log message");
```

會在 Console 上顯示

```log
info: ConsoleApp2.Program[0]
      Example log message
```

---

## Microsoft.Extensions.Logging.EventLog

```csharp
var loggerFactory = LoggerFactory.Create(builder =>
{
    builder.AddEventLog();
});
ILogger logger = loggerFactory.CreateLogger<Program>();
logger.LogInformation("Example log message");
```

會在事件檢視器中顯示 Log 訊息

![Text](./../_images/加入%20WebService%20的方式/01.png)
