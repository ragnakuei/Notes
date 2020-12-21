# Console 範例

[範例](https://github.com/ragnakuei/DotNetHostEnvironment)

## 安裝套件

- Microsoft.Extensions.Hosting
- Microsoft.Extensions.DependencyInjection
- Microsoft.Extensions.Configuration

## 設定 launchSettings.json

設定
- `DOTNET_ENVIRONMENT`
  - 用來給定環境變數
  - 會讀取 appsettings.json
  - 會讀取 appsettings.DOTNET_ENVIRONMENT.json
  - 如果是使用 Asp.Net Core 的話，環境變數可改為使用 `ASPNETCORE_ENVIRONMENT`
- executablePath
  - 如果使用 Rider
    - commandName 要設定成 `Project` 才可以 debug
    - executablePath 
      - 要指向 bin/Debug/xxx/project.dll
      - 要使用絕對路徑
      - 例：C:/Users/User/Documents/Projects/xxx/xxx/bin/Debug/net5.0/xxx.dll。xxx 就是 project name
  - 如果使用 Visual Studio
    - commandName 可以設定成 `Project` 或 `Executable` 都可以 debug
    - executablePath 
      - 要指向 bin/Debug/xxx/project.dll
      - 要使用絕對路徑
      - 例：C:/Users/User/Documents/Projects/xxx/xxx/bin/Debug/net5.0/xxx.dll。xxx 就是 project name

## 語法

```csharp
class Program
{
    static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }

    private static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureServices((hostContext, services) =>
                                {
                                    services.AddHostedService<App>();
                                });
}

public class App : IHostedService
{
    private readonly ILogger<App> _logger;

    private readonly IHostApplicationLifetime _appLifetime;

    private readonly IHostEnvironment _env;

    private readonly IConfiguration _configuration;

    public App(ILogger<App>             logger,
                IHostApplicationLifetime appLifetime,
                IHostEnvironment         env,
                IConfiguration           configuration)
    {
        _logger        = logger;
        _appLifetime   = appLifetime;
        _env           = env;
        _configuration = configuration;
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("App running at: {time}",                  DateTimeOffset.Now);
        _logger.LogInformation("App running at Env: {env}",               _env.EnvironmentName);
        _logger.LogInformation("App running at Configuration Key: {key}", _configuration.GetSection("key").Value);

        await Task.Yield();

        _appLifetime.StopApplication();
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("App stopped at: {time}", DateTimeOffset.Now);
        return Task.CompletedTask;
    }
}
```

## 發佈後執行

- 以 `echo %DOTNET_ENVIRONMENT%` 來檢查是否已設定對應的環境變數
  - 如果顯示 `%DOTNET_ENVIRONMENT%` 代表未設定
  - 以 `set DOTNET_ENVIRONMENT=Test` 來指定目前工作階段的 DOTNET_ENVIRONMENT 環境變數為 Test
  - 以系統管理員身份執行 `setx /m DOTNET_ENVIRONMENT Test` 來設定目前電腦的 DOTNET_ENVIRONMENT 系統環境變數為 Test
    - 移除方式 - 進階系統設定 > 環境變數 > 系統變數 找到 `DOTNET_ENVIRONMENT` 再刪除
- 設定好環境變數後，再執行執行檔，確認已套用

## 參考資料
- [.NET Generic Host in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/host/generic-host)
- [Get started with .NET Generic Host](https://snede.net/get-started-with-net-generic-host/)
- [使用 .NET Generic Host 建立 Console 主控台應用程式 (.NET Core 3.1+)](https://blog.miniasp.com/post/2020/12/08/NET-Generic-Host-Build-Console-App)
- [參考關聯範例](./../../.Net%20Core/Configuration/依照不同%20profile%20讀不同檔案.md)