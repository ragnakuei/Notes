# Configuration Setting 組態檔

目前有以下做法

環境：有以下不同組態設定

| 環境    | 說明      |
| ------- | --------- |
| Debug   | 開發階階  |
| Tst     | 測試機    |
| Uat     | PM 測試機 |
| Release | 正式機    |

1. 透過條件式編譯

```csharp
            var configuration = new ConfigurationBuilder()
                               .SetBasePath(Directory.GetCurrentDirectory())
                               .AddJsonFile("appsettings.json", optional : true)
#if TST
                               .AddJsonFile($"appsettings.Tst.json", optional : true)
#elif UAT
                               .AddJsonFile($"appsettings.Uat.json", optional : true)
#elif RELEASE
                               .AddJsonFile($"appsettings.Release.json", optional : true)
#else
                               .AddJsonFile($"appsettings.Debug.json", optional : true)
#endif
                               .AddEnvironmentVariables()
                               .Build();
```
