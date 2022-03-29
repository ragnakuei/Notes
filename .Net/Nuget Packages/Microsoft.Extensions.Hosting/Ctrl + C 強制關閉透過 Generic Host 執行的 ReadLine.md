# Ctrl + C 強制關閉透過 Generic Host 執行的 ReadLine

執行 HostedService 後，只要內層的 Task 正在執行 Console.ReadLine() 

就必須多按一次 Enter 去完成內層的 Task 正在執行 Console.ReadLine()

解法：

    透過 Control.CancelKeyPress event 做 `Environment.Exit(0)` 就可以了 !


```cs
class Program
{
    static void Main(string[] args)
    {
        Console.CancelKeyPress += delegate {
            Environment.Exit(0);
        };

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

    public App(ILogger<App> logger,
                IHostApplicationLifetime appLifetime,
                IHostEnvironment env,
                IConfiguration configuration)
    {
        _logger = logger;
        _appLifetime = appLifetime;
        _env = env;
        _configuration = configuration;
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("App running at: {time}", DateTimeOffset.Now);
        _logger.LogInformation("App running at Env: {env}", _env.EnvironmentName);
        _logger.LogInformation("App running at Configuration Key: {key}", _configuration.GetSection("key").Value);

        var input = string.Empty;

        while (!cancellationToken.IsCancellationRequested)
        {
            Console.WriteLine("Please Any Keys");
            input = Console.ReadLine();

        }

        Console.WriteLine("End");

        _appLifetime.StopApplication();
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("App stopped at: {time}", DateTimeOffset.Now);
        return Task.CompletedTask;
    }
}
```

### 另一個可行性

https://stackoverflow.com/questions/57615/how-to-add-a-timeout-to-console-readline


### 當時想的另一個可能性

透過 timer (間隔固定時間) 啟動 ReadLine，以避免 HostedService 卡住，無法做額外的判斷 !

```cs
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

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
    private System.Timers.Timer _timer;

    public App(ILogger<App> logger,
                IHostApplicationLifetime appLifetime,
                IHostEnvironment env,
                IConfiguration configuration)
    {
        _logger = logger;
        _appLifetime = appLifetime;
        _env = env;
        _configuration = configuration;

        
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("App running at: {time}", DateTimeOffset.Now);
        _logger.LogInformation("App running at Env: {env}", _env.EnvironmentName);
        _logger.LogInformation("App running at Configuration Key: {key}", _configuration.GetSection("key").Value);

        _timer = new System.Timers.Timer(2000);
        _timer.Elapsed += Timer_Elapsed;
        _timer.Start();
    }

    private void Timer_Elapsed(object? sender, System.Timers.ElapsedEventArgs e)
    {
        _timer.Stop();
        Console.WriteLine("Please Any Keys");
        _timer.Start();
        var input = Console.ReadLine();
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("App stopped at: {time}", DateTimeOffset.Now);
        return Task.CompletedTask;
    }
}
```
