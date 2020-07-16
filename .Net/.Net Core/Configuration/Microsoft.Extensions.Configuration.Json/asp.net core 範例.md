# asp.net core 範例

CreateDefaultBuilder() 預設就會讀取 appsettings.json

## 讀取額外的 .json

```csharp
public class Program
{
    public static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args)
        => Host.CreateDefaultBuilder(args)
                // 增加以下這段語法
                .ConfigureAppConfiguration((hostingContext, config) =>
                                            {
                                                // 下面這行是多寫的
                                                config.AddJsonFile("appsettings.json", false, true);

                                                // 讀取額外指定的 json 檔
                                                config.AddJsonFile("a.json",           false, true);
                                            })
                .ConfigureWebHostDefaults(webBuilder =>
                                            {
                                                webBuilder.UseStartup<Startup>();
                                            });
}
```
