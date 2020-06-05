# Microsoft.Extensions.Logging

## [Providers](docs.microsoft.com/zh-tw/aspnet/core/fundamentals/logging#built-in-logging-providers)

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



