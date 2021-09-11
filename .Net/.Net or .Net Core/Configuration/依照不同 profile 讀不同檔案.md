# 依照不同 profile 讀不同檔案

profile 的定義檔在 `Properties/launchSettings.json` 中的 profiles 中

可以對不同 profile 給定不同的 ASPNETCORE_ENVIRONMENT 值

```json
{
    "iisSettings": {
        "windowsAuthentication": false,
        "anonymousAuthentication": true,
        "iisExpress": {
            "applicationUrl": "http://localhost:3869",
            "sslPort": 44304
        }
    },
    "profiles": {
        "IIS Express": {
            "commandName": "IISExpress",
            "launchBrowser": true,
            "environmentVariables": {
                "ASPNETCORE_ENVIRONMENT": "Development"
            }
        },
        "WebApplication": {
            "commandName": "Project",
            "launchBrowser": true,
            "applicationUrl": "https://localhost:5001;http://localhost:5000",
            "environmentVariables": {
                "ASPNETCORE_ENVIRONMENT": "Development"
            }
        },
        "WebApplicationTst": {
            "commandName": "Project",
            "launchBrowser": true,
            "applicationUrl": "https://localhost:5001;http://localhost:5000",
            "environmentVariables": {
                "ASPNETCORE_ENVIRONMENT": "Tst"
            }
        },
        "WebApplicationUat": {
            "commandName": "Project",
            "launchBrowser": true,
            "applicationUrl": "https://localhost:5001;http://localhost:5000",
            "environmentVariables": {
                "ASPNETCORE_ENVIRONMENT": "Uat"
            }
        },
        "WebApplicationPrePrd": {
            "commandName": "Project",
            "launchBrowser": true,
            "applicationUrl": "https://localhost:5001;http://localhost:5000",
            "environmentVariables": {
                "ASPNETCORE_ENVIRONMENT": "PrePrd"
            }
        }
    }
}
```

然後在 `program.cs` 中

就可以取出 `ASPNETCORE_ENVIRONMENT` 所指定的值，來抓取對應的組態設定檔

```csharp
public class Program
{
    public static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args)
        => Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((hostingContext, config) =>
                                            {
                                                // HostingEnvironment.EnvironmentName 就可以取出 ASPNETCORE_ENVIRONMENT 所給定的值
                                                var env = hostingContext.HostingEnvironment;
                                                config.AddJsonFile($"appsettings.{env.EnvironmentName}.json",false, true);
                                            })
                .ConfigureWebHostDefaults(webBuilder =>
                                            {
                                                webBuilder.UseStartup<Startup>();
                                            });
}
```

然後在 IDE 上就可以選擇指定的 profile 來執行網站

-   Visual Studio 可以直接在上方工具列選擇
-   Rider 要先建立 `.Net Launch Settings Profile` 後，再 選擇指定的 `Launch profile` !
