# Json

在 asp.net core 中，預設的 Json 處理套件為 `System.Text.Json`

## 讓 Property 保留原本 Case

因為 Property 的預設處理方式是 Camel Case，如果需要保留原本的 case 可以套用以下語法

Startup.ConfigureServices()

```csharp
services.AddControllersWithViews()

        // 加上下面這行
        .AddJsonOptions(options => options.JsonSerializerOptions.PropertyNamingPolicy = null);

        // 這是預設值
        // .AddJsonOptions(options => options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase);
```
