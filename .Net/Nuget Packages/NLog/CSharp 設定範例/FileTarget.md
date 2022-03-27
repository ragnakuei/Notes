# FileTarget

```cs
using NLog.Config;
using NLog.Targets;
using NLog.Web;

var processPath = AppDomain.CurrentDomain.BaseDirectory;
var fileTarget = new FileTarget
                    {
                        Name     = "file01",
                        FileName = logDirPath + "/log/${shortdate}.log",
                        Layout   = "${longdate} ${uppercase:${level}} ${logger} ${message}",
                    };
                    
var config = new LoggingConfiguration();
config.AddRule(NLog.LogLevel.Debug, NLog.LogLevel.Fatal, fileTarget, "*");
NLog.LogManager.Configuration = config;
NLogBuilder.ConfigureNLog(NLog.LogManager.Configuration).GetCurrentClassLogger();
```