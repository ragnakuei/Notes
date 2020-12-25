# console + Hosting 範例

- 讀取 appsettings.json
  - 記得將檔案設定成 `copy to output directory`
  - IConfiguration `預設`就會讀取 apppsettings.json，不需要特別指定
  - 預設會讀取 appsettings.json 中的 Serilog property 的結構
    - [可手動指定](#手動指定為-customsection)
- 方式一
  - 脫離原本 Hosting 的設定
- 方式二
  - 與原本 Hosting 的設定整合

```csharp
class Program
{
    static void Main(string[] args)
    {
        // 方式一
        // var configuration = new ConfigurationBuilder()
        //                    .SetBasePath(Directory.GetCurrentDirectory())
        //                    .AddJsonFile(path: "appsettings.json", true)
        //                    .Build();
        //
        // Log.Logger = new LoggerConfiguration()
        //             .ReadFrom.Configuration(configuration)
        //             .Enrich.WithProperty("App Name", "Serilog Web App Sample")
        //             .CreateLogger();

        CreateHostBuilder(args)
           .UseSerilog() // 套件 Serilog.AspNetCore
           .Build()
           .Run();
    }

    private static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureServices((hostContext, services) =>
                               {
                                   services.AddHostedService<App>();
                               })
            .ConfigureAppConfiguration(config =>
                                       {
                                           // 方式二
                                           Log.Logger = new LoggerConfiguration()
                                                       .ReadFrom.Configuration(config.Build())
                                                       .CreateLogger();
                                       });
}

public class App : IHostedService
{
    private readonly ILogger<App> _logger;

    private readonly IHostApplicationLifetime _appLifetime;

    private readonly IConfiguration _configuration;

    public App(ILogger<App>             logger,
               IHostApplicationLifetime appLifetime,
               IConfiguration           configuration)
    {
        _logger        = logger;
        _appLifetime   = appLifetime;
        _configuration = configuration;
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("App running at: {time}",                  DateTimeOffset.Now);
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

appsettings.json

```json
{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Verbose",
      "Override": {
        "System": "Verbose",
        "Microsoft": "Verbose"
      }
    },
    "WriteTo": [
      {
        "Name": "Console"
      },
      {
        "Name": "File",
        "Args": {
          "path": "Logs/log.txt"
        }
      },
      {
        "Name": "Seq",
        "Args": {
          "serverUrl": "http://seq:5341/",
          "compact": true
        }
      }
    ],
    "Enrich": [
      "FromLogContext"
    ]
  }
}
```

### 手動指定為 CustomSection
```csharp
var logger = new LoggerConfiguration()
    .ReadFrom.Configuration(configuration, sectionName: "CustomSection")
    .CreateLogger();
```

```json
{
  "CustomSection": {
    // TODO
  }
}
```