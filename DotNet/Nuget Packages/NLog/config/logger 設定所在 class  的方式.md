# logger 設定所在 class  的方式

在設定檔中的 `targets > target` 把 layout 改成

> `layout="${longdate} ${uppercase:${level}} ${logger} ${message}"`

## Action - logger 設定方式一

```csharp
public ActionResult Index()
{
    Logger logger = LogManager.GetCurrentClassLogger();
    logger.Trace("我是Trace");
    logger.Debug("我是Debug");
    logger.Info("我是Info");
    logger.Warn("我是Warn");
    logger.Error("我是Error");
    logger.Fatal("我是Fatal");

    return View();
}
```

## Action - logger 設定方式二

```csharp
public class HomeController : Controller
{
    static ILogger _logger = LogManager.GetCurrentClassLogger(typeof(HomeController));

    // GET: Home
    public ActionResult Index()
    {
        _logger.Trace("我是Trace");
        _logger.Debug("我是Debug");
        _logger.Info("我是Info");
        _logger.Warn("我是Warn");
        _logger.Error("我是Error");
        _logger.Fatal("我是Fatal");

        return View();
    }
}
```

## 產生的 log 內容如下

```log
2017-06-01 09:47:58.3830 DEBUG nlogPractice01.Controllers.HomeController 我是Debug
2017-06-01 09:47:58.3830 INFO nlogPractice01.Controllers.HomeController 我是Info
2017-06-01 09:47:58.3950 WARN nlogPractice01.Controllers.HomeController 我是Warn
2017-06-01 09:47:58.3950 ERROR nlogPractice01.Controllers.HomeController 我是Error
2017-06-01 09:47:58.3950 FATAL nlogPractice01.Controllers.HomeController 我是Fatal
```