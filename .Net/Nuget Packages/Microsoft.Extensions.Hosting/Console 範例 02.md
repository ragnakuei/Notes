# Console 範例

```cs
await Host.CreateDefaultBuilder(args)
          .ConfigureAppConfiguration((context, configugration) =>
                                     {
                                         // 如需手動設定，請參考以下
                                         configugration.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
                                     })
          .ConfigureServices((hostContext, services) =>
                             {
                                 services.AddTransient<Function01>();

                                 services.AddHostedService<App>();
                             })
          .Build()
          .RunAsync();
```

```cs
public class App : IHostedService
{
    private readonly IHostApplicationLifetime _appLifetime;
    private readonly IServiceScopeFactory     _serviceScopeFactory;

    public App(IHostApplicationLifetime appLifetime,
               IServiceScopeFactory     serviceScopeFactory)
    {
        _appLifetime         = appLifetime;
        _serviceScopeFactory = serviceScopeFactory;
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        Console.WriteLine("App is starting.");

        try
        {
            await _serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<Function01>().RunAsync(llm);
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
        }

        _appLifetime.StopApplication();
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        Console.WriteLine("App is stopping.");

        return Task.CompletedTask;
    }
}
```
