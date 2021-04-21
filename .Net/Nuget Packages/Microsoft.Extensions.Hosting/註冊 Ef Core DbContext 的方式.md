# 註冊 Ef Core DbContext 的方式

- 在 ConfigureServices() 裡面取用 IConfiguration 的方式
  - 透過 hostContext.Configuration

```csharp
class Program
{
    static void Main(string[] args)
    {
        Host.CreateDefaultBuilder(args)
            .ConfigureAppConfiguration((hostingContext, config) =>
                                        {
                                            config.AddJsonFile("appsettings.json", false, true);
#if DEBUG
                                            config.AddJsonFile("appsettings.Debug.json", optional: false);
#endif
                                        })
            .ConfigureServices((hostContext, services) =>
                                {
                                    services.AddHostedService<App>();
                                    services.AddDbContext<CreateDbContext>(options =>
                                                                            {
                                                                                options.UseSqlServer(hostContext.Configuration.GetConnectionString("DefaultConnection"),
                                                                                                    builder =>
                                                                                                    {
                                                                                                        builder.CommandTimeout(2400);
                                                                                                        builder.EnableRetryOnFailure(2);
                                                                                                        builder.MigrationsHistoryTable("_MigrationsHistory", hostContext.Configuration.Get<AppSettingsDto>().Db.DefaultSchema);
                                                                                                        builder.MigrationsAssembly("CreateDb");
                                                                                                    })
                                                                                        .UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
                                                                            },
                                                                            ServiceLifetime.Transient,
                                                                            ServiceLifetime.Transient);
                                })
            .Build()
            .Run();
    }
}
```