# ILogger

這個無法照原本的邏輯來處理
可以參考這個說明
https://codeburst.io/unit-testing-with-net-core-ilogger-t-e8c16c503a80

### 輸出至 Console 的方式

```cs
using var loggerFactory = LoggerFactory.Create(builder =>
                                               {
                                                   builder.AddConsole();
                                                   builder.AddFilter("*", LogLevel.Trace);
                                               });
var logger = loggerFactory.CreateLogger<QueueService<TestDto>>();
```
