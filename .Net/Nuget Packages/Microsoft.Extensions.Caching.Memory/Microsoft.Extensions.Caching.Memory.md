# [Microsoft.Extensions.Caching.Memory](https://docs.microsoft.com/zh-tw/dotnet/api/microsoft.extensions.caching.memory?view=dotnet-plat-ext-3.1)

## 套用至 Asp.Net Core 中

Startup.cs > ConfigureServices() 中加上

```
services.AddMemoryCache();
```

就可以 DI `IMemoryCache`
