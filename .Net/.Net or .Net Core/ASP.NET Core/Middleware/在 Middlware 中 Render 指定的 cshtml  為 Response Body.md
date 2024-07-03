# 在 Middlware 中 Render 指定的 cshtml 為 Response Body

## 方式一：直接 Render cshtml 內容至 HttpContext 中

_JsAlert.cshtml 內容跟 cshtml 一樣，不需要特別處理

```cs
private async Task AlertExceptionAsync(HttpContext context, AlertException ex)
{
    context.Response.StatusCode  = (int)HttpStatusCode.BadRequest;
    context.Response.ContentType = "text/html";
    await RenderCshtmlAsync(context, "~/Views/Shared/_JsAlert.cshtml", ex);
}


private async Task RenderCshtmlAsync(HttpContext    context,
                                     string         viewName,
                                     AlertException alertException)
{
    var viewResult = new ViewResult
                     {
                         ViewName = viewName,
                     };
    var viewDataDictionary = new ViewDataDictionary(new EmptyModelMetadataProvider(),
                                                    new ModelStateDictionary());
    viewDataDictionary.Model = new JsAlertViewModel
                               {
                                   CspNonce     = context.RequestServices.GetRequiredService<CspRepository>().GetNonce(),
                                   AlertMessage = alertException.AlertMessage,
                                   RedirectUrl  = alertException.RedirectUrl,
                               };
    viewResult.ViewData = viewDataDictionary;

    var executor = context.RequestServices
                          .GetRequiredService<IActionResultExecutor<ViewResult>>();
    var routeData = context.GetRouteData() ?? new RouteData();
    var actionContext = new ActionContext(context,
                                          routeData,
                                          new ActionDescriptor());

    await executor.ExecuteAsync(actionContext, viewResult);
}
```

### 方式二：Render cshtml 內容至 string

尚末找到實作方式
