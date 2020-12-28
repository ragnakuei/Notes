# [Serilog.Sinks.Seq](https://github.com/serilog/serilog-sinks-seq)

## C# 指定參數

[WriteTo.Seq()](https://github.com/serilog/serilog-sinks-seq/blob/439e1456eb864138268fd6abf240b77ff2e81213/src/Serilog.Sinks.Seq/SeqLoggerConfigurationExtensions.cs#L66) 可指定多個參數

```csharp
Log.Logger = new LoggerConfiguration()
            // .ReadFrom.Configuration(config.Build())
            .WriteTo.Seq("http://seq:5341/")
            .CreateLogger();
```

## appsettings.json 指定參數

Args 中的參數，與 [WriteTo.Seq()](https://github.com/serilog/serilog-sinks-seq/blob/439e1456eb864138268fd6abf240b77ff2e81213/src/Serilog.Sinks.Seq/SeqLoggerConfigurationExtensions.cs#L66) 參數名稱相同

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