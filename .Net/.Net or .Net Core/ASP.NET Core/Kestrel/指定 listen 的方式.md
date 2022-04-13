# 指定 listen 的方式

[Configure endpoints for the ASP.NET Core Kestrel web server](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/kestrel/endpoints)


### 透過 dotnet cli 指定

> dotnet [專案名].dll --urls "http://0.0.0.0:5000"

### 透過 appsettings.json 指定

Kestrel 區段

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "Kestrel": {
    "Endpoints": {
      "Http": {
        "Url": "http://0.0.0.0:5000"
      },
      "Https": {
        "Url": "https://0.0.0.0:5001"
      }
    }
  },
  "AllowedHosts": "*"
}
```

### 透過程式指定

```cs
var builder = WebApplication.CreateBuilder(args);

builder.WebHost.ConfigureKestrel(serverOptions =>
                                 {
                                     serverOptions.Listen(IPAddress.Any,
                                                          5000,
                                                          listenOptions =>
                                                          {
                                                          });
                                 });
```