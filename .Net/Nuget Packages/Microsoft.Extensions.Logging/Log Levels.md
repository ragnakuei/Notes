# Log Levels

從最低到最高

-   Trace = 0
-   Debug = 1
-   Information = 2
-   Warning = 3
-   Error = 4
-   Critical = 5

## 設定 Log Level 的方式

因為 CreateDefaultBuilder() 預設會使用 [File configuration provider](https://docs.microsoft.com/zh-tw/aspnet/core/fundamentals/configuration/)

目前測試的是 ILoggingBuilder.SetMinimumLevel() 的設定會被 上述的設定蓋掉 !

```csharp
Host.CreateDefaultBuilder(args)
    .ConfigureLogging(configureLogging =>
                        {
                            configureLogging.ClearProviders();

                            // 這行就不重要了
                            // configureLogging.SetMinimumLevel(LogLevel.Critical);
                        })
```

另一方面是 套件有提供的 Minimum Log Level 設定，而 Provider 也是提供 Minimum Log Level 設定

目前測試，以套件提供的 Minimum Log Level 設定為主，而 Provier 的 Minimum Log Level 設定就設定為全開，會比較好處理
