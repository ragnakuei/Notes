# Asp.Net Core 取得 HttpClient 方式

[Make HTTP requests using IHttpClientFactory in ASP.NET Core](https://docs.microsoft.com/zh-tw/aspnet/core/fundamentals/http-requests)

## 步驟

1. Startup.ConfigureServices()

```csharp
services.AddHttpClient();
```

方式一：

1. 建構子 DI IHttpClientFactory

```csharp
public Constructor(IHttpClientFactory clientFactory)
{
    _clientFactory = clientFactory;
}
```

1. 透過 IHttpClientFactory.CreateClient() 來建立 HttpClient instance

```csharp
HttpClient client = _clientFactory.CreateClient();
```

方式二：

DI HttpClient

```csharp
private readonly HttpClient _client;

public Constructor(HttpClient client)
{
    _client = client;
}
```