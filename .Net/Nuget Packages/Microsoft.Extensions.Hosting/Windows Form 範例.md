# Windows Form 範例

```cs
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace ParseAspxTitle
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize();

            Host.CreateDefaultBuilder(null)
                .ConfigureServices((hostContext, services) =>
                                   {
                                       services.AddSingleton<Form1>();
                                       services.AddHostedService<App>();
                                   })
                .Build()
                .Run();
        }
    }

    public class App : IHostedService
    {
        private readonly ILogger<App>             _logger;
        private readonly IHostApplicationLifetime _appLifetime;
        private readonly IHostEnvironment         _env;
        private readonly IConfiguration           _configuration;
        private readonly Form1                    _form1;

        public App(ILogger<App>             logger,
                   IHostApplicationLifetime appLifetime,
                   IHostEnvironment         env,
                   IConfiguration           configuration,
                   Form1                    form1)
        {
            _logger        = logger;
            _appLifetime   = appLifetime;
            _env           = env;
            _configuration = configuration;
            _form1    = form1;
        }

        public async Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("App running at: {time}",                  DateTimeOffset.Now);
            _logger.LogInformation("App running at Env: {env}",               _env.EnvironmentName);
            _logger.LogInformation("App running at Configuration Key: {key}", _configuration.GetSection("key").Value);

            Application.Run(_form1);

            await Task.Yield();

            _appLifetime.StopApplication();
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("App stopped at: {time}", DateTimeOffset.Now);
            return Task.CompletedTask;
        }
    }
}
```