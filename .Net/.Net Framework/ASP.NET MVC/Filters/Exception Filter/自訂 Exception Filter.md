# 自訂 Exception Filter

---

使用方式與 [預設 Exception Filter](./預設%20Exception%20Filter%20HandleErrorAttribute.md) 一樣

### 範例

要繼承 `FilterAttribute`、實作 `IExceptionFilter`

```csharp
using System;
using System.Web.Mvc;

namespace filter
{
    public class CustomErrorAttribute : FilterAttribute, IExceptionFilter
    {
        readonly log4net.ILog logger = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        public void OnException(ExceptionContext filterContext)
        {
            log4net.Config.XmlConfigurator.Configure();            
            var controllerName = (string)filterContext.RouteData.Values["controller"];
            var actionName = (string)filterContext.RouteData.Values["action"];
            logger.Debug($"{controllerName}/{actionName}中發生以下錯誤：\r\n{filterContext.Exception.Message}");

            //如果沒有加下面這行，RedirectResult 就會失效
            filterContext.ExceptionHandled = true;
            filterContext.Result = new RedirectResult("~/home/index");
        }
    }
}
```