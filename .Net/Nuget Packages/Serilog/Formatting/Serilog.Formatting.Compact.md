# [Serilog.Formatting.Compact](https://github.com/serilog/serilog-formatting-compact)

## 設定

### appsettings.json

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


## 範例

如果要以 json serialize 的方式寫入
- 要用 {@Message}
- 不要用 {Message}

```csharp
_logger.LogInformation("{@Message}",
                        new
                        {
                            Name = "nblumhardt",
                            Tags = new[] { 1, 2, 3 },
                            Now = DateTime.Now,
                        });
```