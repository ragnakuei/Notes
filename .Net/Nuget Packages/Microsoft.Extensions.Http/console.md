# console

## 步驟

1. 安裝套件 
   - [Microsoft.Extensions.Hosting](./../../../Nuget%20Packages/Microsoft.Extensions.Hosting/Console%20範例.md)
   - Microsoft.Extensions.Http
1.  程式

    Program.cs

    ```csharp
    class Program
    {
        static async Task Main(string[] args)
        {
            var host = new HostBuilder()
                    .ConfigureLogging(configureLogging =>
                                        {
                                            // 在 console 上顯示 ILogger 的訊息
                                            configureLogging.AddConsole();
                                        })
                    .ConfigureServices((hostContext, services) =>
                                        {
                                            services.AddHttpClient();
                                            services.AddTransient<MyApplication>();
                                        })
                    .UseConsoleLifetime()
                    .Build();

            using (var serviceScope = host.Services.CreateScope())
            {
                var services = serviceScope.ServiceProvider;

                try
                {
                    var myService = services.GetRequiredService<MyApplication>();
                    await myService.RunAsync();
                }
                catch (Exception)
                {
                    Console.WriteLine("Error Occured");
                }
            }
        }
    }
    ```

    MyApplication.cs

    ```csharp
    public class MyApplication
    {
        private readonly ILogger<MyApplication> _logger;
        private readonly IHttpClientFactory     _httpFactory;

        public MyApplication(ILogger<MyApplication> logger,
                            IHttpClientFactory     httpFactory)
        {
            _logger      = logger;
            _httpFactory = httpFactory;
        }

        public async Task RunAsync()
        {
            _logger.LogInformation("Application {applicationEvent} at {dateTime}", "Started", DateTime.Now);

            var request = new HttpRequestMessage(HttpMethod.Post, "https://localhost:8085/Test/Plus");

            var client   = _httpFactory.CreateClient();
            var response = await client.SendAsync(request);

            _logger.LogInformation("StatusCode {statusCode} at {dateTime}", response.StatusCode, DateTime.Now);

            _logger.LogInformation("Application {applicationEvent} at {dateTime}", "Ended", DateTime.Now);
        }
    }
    ```