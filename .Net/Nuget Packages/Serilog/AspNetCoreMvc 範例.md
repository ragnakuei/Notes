# AspNetCoreMvc 範例

套件
- Serialog
- Serilog.AspNetCore
- Serilog.Formatting.Compact


startup.cs

```csharp
public static void Main(string[] args)
{
    Host.CreateDefaultBuilder(args)

        // serilog
        .UseSerilog((hostingContext, loggerConfiguration) =>
                    {
                        loggerConfiguration.ReadFrom.Configuration(hostingContext.Configuration);
                    })
        .ConfigureWebHostDefaults(webBuilder =>
                                  {
                                      webBuilder.UseStartup<Startup>();
                                  })
        .Build()
        .Run();
}
```

appsettings.json

```json
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
        "Name": "File",
        "Args": {
            "formatter": "Serilog.Formatting.Compact.CompactJsonFormatter, Serilog.Formatting.Compact",
            "path": "../Files/Logs/log.json",
            "rollingInterval" : "Day"
        }
        }
    ]
}
```

HomeController.cs

```csharp
public IActionResult Index()
{
    _logger.LogInformation("{@Message}",
                            new
                            {
                                Name = "nblumhardt",
                                Tags = new[] { 1, 2, 3 },
                                Now = DateTime.Now,
                            });

    throw new Exception("TestXXX");

    return View();
}
```