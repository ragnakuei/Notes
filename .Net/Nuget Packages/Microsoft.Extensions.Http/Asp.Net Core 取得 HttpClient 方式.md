# Asp.Net Core 取得 HttpClient 方式

[Make HTTP requests using IHttpClientFactory in ASP.NET Core](https://docs.microsoft.com/zh-tw/aspnet/core/fundamentals/http-requests)

## 步驟

1. Startup.ConfigureServices()

```csharp
services.AddHttpClient();
```

### 方式一：

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

### 設定 TImeout 與不同設定檔 的方式

```csharp
static void Main(string[] args)
{
	Host.CreateDefaultBuilder(args)
		.ConfigureLogging((context, logging) =>
					  {
						  logging.ClearProviders();
					  })
		.ConfigureServices((hostContext, services) =>
						   {
                               // 給定設定檔名稱
							   services.AddHttpClient("HttpClientName", config => {

                                    // 設定 Timeout 值
							   		config.Timeout = TimeSpan.FromMinutes(5);
							   });
							   services.AddTransient<RunService>();
                               services.AddHostedService<App>();
                           })
        .Build()
        .Run();
}

// ...

public class RunService
{ 
    private readonly IHttpClientFactory _clientFactory;
    
    public RunService(IHttpClientFactory clientFactory)
    {
        _clientFactory = clientFactory;
    }

	private readonly int _count = 10000;
	
	private readonly string _chargeUrl = "https://localhost:5001/user/charge";
	private readonly StringContent _chargeContent = new StringContent(JsonConvert.SerializeObject(new Dto { Id = 1, Money = 2 }),
																	  Encoding.UTF8,
																	  "application/json");

	private readonly string _consumeUrl = "https://localhost:5001/user/consume";
	private readonly StringContent _consumeContent = new StringContent(JsonConvert.SerializeObject(new Dto { Id = 1, Money = 1 }),
													 				   Encoding.UTF8,
																	   "application/json");

    // ...

	private async Task PostAsync(string url, StringContent content)
	{
        // 取出時，要給定 設定檔名稱
		var response = await _clientFactory.CreateClient("HttpClientName").PostAsync(url, content);
		response.EnsureSuccessStatusCode();
	}

}
```

### 方式二：

DI HttpClient

```csharp
private readonly HttpClient _client;

public Constructor(HttpClient client)
{
    _client = client;
}
```