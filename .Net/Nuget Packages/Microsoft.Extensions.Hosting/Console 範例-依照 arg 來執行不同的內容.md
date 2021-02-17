# Console 範例-依照 arg 來執行不同的內容

- 必須建立 abstract class HostedServiceBase 來閃過 IServiceCollection.AddHostedService() 的判斷
  - IServiceCollection.AddHostedService() 的判斷
    - 回傳的資料型態不能是 IHostedService
    - 回傳的資料型態能是實作 IHostedService 的類別

```csharp
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace ConsoleAppArgsTest
{
    class Program
    {
        static void Main(string[] args)
        {
            Host.CreateDefaultBuilder(args)
                .ConfigureServices((hostContext, services) =>
                                   {
                                       services.AddScoped<HostedServiceFactory>();
                                       services.AddScoped<AppA>();
                                       services.AddScoped<AppB>();

                                       services.AddHostedService(service => service.GetService<HostedServiceFactory>()
                                                                                  ?.GetHostedService(args?.FirstOrDefault()));
                                   })
                .Build()
                .Run();
        }
    }

    public class HostedServiceFactory
    {
        private readonly IServiceProvider _serviceProvider;

        public HostedServiceFactory(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }

        public HostedServiceBase GetHostedService(string arg)
        {
            return arg switch
                   {
                       "A" => _serviceProvider.GetService<AppA>(),
                       "B" => _serviceProvider.GetService<AppB>(),
                       _   => throw new NotImplementedException(),
                   };
        }
    }

    /// <summary>
    /// 用來閃過 IServiceCollection.AddHostedService() 的判斷
    /// </summary>
    public abstract class HostedServiceBase : IHostedService
    {
        public abstract Task StartAsync(CancellationToken cancellationToken);

        public abstract Task StopAsync(CancellationToken cancellationToken);
    }

    public class AppA : HostedServiceBase
    {
        private readonly ILogger<AppA> _logger;

        private readonly IHostApplicationLifetime _appLifetime;

        private readonly IHostEnvironment _env;

        private readonly IConfiguration _configuration;

        public AppA(ILogger<AppA>            logger,
                    IHostApplicationLifetime appLifetime,
                    IHostEnvironment         env,
                    IConfiguration           configuration)
        {
            _logger        = logger;
            _appLifetime   = appLifetime;
            _env           = env;
            _configuration = configuration;
        }

        public override async Task StartAsync(CancellationToken cancellationToken)
        {
            Console.WriteLine("A");

            await Task.Yield();

            _appLifetime.StopApplication();
        }

        public override Task StopAsync(CancellationToken cancellationToken)
        {
            return Task.CompletedTask;
        }
    }

    public class AppB : HostedServiceBase
    {
        private readonly ILogger<AppB> _logger;

        private readonly IHostApplicationLifetime _appLifetime;

        private readonly IHostEnvironment _env;

        private readonly IConfiguration _configuration;

        public AppB(ILogger<AppB>            logger,
                    IHostApplicationLifetime appLifetime,
                    IHostEnvironment         env,
                    IConfiguration           configuration)
        {
            _logger        = logger;
            _appLifetime   = appLifetime;
            _env           = env;
            _configuration = configuration;
        }

        public override async Task StartAsync(CancellationToken cancellationToken)
        {
            Console.WriteLine("B");

            await Task.Yield();

            _appLifetime.StopApplication();
        }

        public override Task StopAsync(CancellationToken cancellationToken)
        {
            return Task.CompletedTask;
        }
    }
}
```