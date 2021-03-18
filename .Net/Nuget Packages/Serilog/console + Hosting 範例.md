# console + Hosting 範例

- 方式一 > 脫離原本 Hosting 的設定
- 方式二 > 與原本 Hosting 的設定整合
- 方式三 > 更明確的呼叫方式
- 套件
  - Microsoft.Extensions.Hosting
  - Microsoft.Extensions.DependencyInjection
  - Microsoft.Extensions.Configuration
  - Microsoft.Extensions.Logging
  - Serilog
  - Serilog.AspNetCore
  - Serilog.Sinks.Console
  - Serilog.Sinks.File

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
           // .UseSerilog()

           // 方式三
           .UseSerilog((hostingContext, loggerConfiguration) =>
                       {
                           loggerConfiguration.ReadFrom.Configuration(hostingContext.Configuration);
                       }) // 套件 Serilog.AspNetCore
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
                                           // Log.Logger = new LoggerConfiguration()
                                           //             .ReadFrom.Configuration(config.Build())
                                           //             .CreateLogger();
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

