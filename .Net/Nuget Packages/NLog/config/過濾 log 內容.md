# 過濾 log 內容

可透過

> `<logger name="Microsoft.*" minlevel="Trace" writeTo="blackhole" final="true" />`

將設定寫入空的地方

---

## Asp.Net Core 範例

### 安裝套件

> Install-Package NLog.Web.AspNetCore

### startup.cs 

加入以下藍色語法  

會包含 Server 本身執行的 Log  


```csharp
public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }

    loggerFactory.AddNLog();
    env.ConfigureNLog("nlog.config");  //讀取Nlog配置文件

    app.UseMvc();
}
```

### 新增 nlog.config 至專案目錄下

會將 log 放到二個 log file 中
1. allfile
1. ownFile-web

```xml
<?xml version="1.0" encoding="utf-8" ?>
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      autoReload="true"
      internalLogLevel="Warn"
      internalLogFile="internal-nlog.txt">

  <!--define various log targets-->
  <targets>

    <!--write logs to file-->
    <target xsi:type="File" 
            name="allfile" 
            fileName="nlog-all-${shortdate}.log"
            layout="${longdate}|${logger}|${uppercase:${level}}|${message} ${exception}"
            encoding="utf-8" />

    <target xsi:type="File" 
            name="ownFile-web" 
            fileName="nlog-my-${shortdate}.log"
            layout="${longdate}|${logger}|${uppercase:${level}}|${message} ${exception}"
            encoding="utf-8" />

    <target xsi:type="Null" name="blackhole" />

  </targets>

  <rules>
    <!--All logs, including from Microsoft-->
    <logger name="*" minlevel="Trace" writeTo="allfile" />

    <!--Skip Microsoft logs and so log only own logs-->
    <logger name="Microsoft.*" minlevel="Trace" writeTo="blackhole" final="true" />
    <logger name="*" minlevel="Trace" writeTo="ownFile-web" />
  </rules>
</nlog>
```

### Controller

```csharp
using Microsoft.AspNetCore.Mvc;
using NLog;

namespace WebApplication6.Controllers
{
    [Route("api/[controller]")]
    public class ValuesController : Controller
    {
        private static readonly ILogger Logger = LogManager.GetCurrentClassLogger();

        [HttpGet]
        [Route("{id}")]
        public IActionResult Get(int id)
        {
            Logger.Info("普通信息日志-----------");
            Logger.Debug("调试日志-----------");
            Logger.Error("错误日志-----------");
            Logger.Fatal("异常日志-----------");
            Logger.Warn("警告日志-----------");
            Logger.Trace("跟踪日志-----------");
            Logger.Log(NLog.LogLevel.Warn, "Log日志------------------");

            return Json(new string[] { "value1", "value2" });
        }
    }
}
```

檔案會在 專案目錄\bin\Debug\netcoreapp2.1\ 中	
