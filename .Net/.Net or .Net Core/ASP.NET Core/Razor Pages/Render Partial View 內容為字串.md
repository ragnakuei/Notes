# Render Partial View 內容為字串

資料來源：[Programmatically render Razor Page as HTML string](https://stackoverflow.com/questions/63297920/programmatically-render-razor-page-as-html-string)

- 被呼叫的 cshtml
  - 必須是 Partial View
  - 不可以給定 @page

```cs
public class RazorPartialToStringRenderer
{
    private IRazorViewEngine  _viewEngine;
    private ITempDataProvider _tempDataProvider;
    private IServiceProvider  _serviceProvider;

    public RazorPartialToStringRenderer(IRazorViewEngine  viewEngine,
                                        ITempDataProvider tempDataProvider,
                                        IServiceProvider  serviceProvider)
    {
        _viewEngine       = viewEngine;
        _tempDataProvider = tempDataProvider;
        _serviceProvider  = serviceProvider;
    }

    public async Task<string> RenderPartialToStringAsync<TModel>(string partialName, TModel model)
    {
        var actionContext = GetActionContext();
        var partial       = FindView(actionContext, partialName);
        using (var output = new StringWriter())
        {
            var viewContext = new ViewContext(
                                              actionContext,
                                              partial,
                                              new ViewDataDictionary<TModel>(
                                                                             metadataProvider: new EmptyModelMetadataProvider(),
                                                                             modelState: new ModelStateDictionary())
                                              {
                                                  Model = model
                                              },
                                              new TempDataDictionary(
                                                                     actionContext.HttpContext,
                                                                     _tempDataProvider),
                                              output,
                                              new HtmlHelperOptions()
                                             );
            await partial.RenderAsync(viewContext);
            return output.ToString();
        }
    }

    private IView FindView(ActionContext actionContext, string partialName)
    {
        var getPartialResult = _viewEngine.GetView(null, partialName, false);
        if (getPartialResult.Success)
        {
            return getPartialResult.View;
        }

        var findPartialResult = _viewEngine.FindView(actionContext, partialName, false);
        if (findPartialResult.Success)
        {
            return findPartialResult.View;
        }

        var searchedLocations = getPartialResult.SearchedLocations.Concat(findPartialResult.SearchedLocations);
        var errorMessage = string.Join(
                                       Environment.NewLine,
                                       new[] { $"Unable to find partial '{partialName}'. The following locations were searched:" }.Concat(searchedLocations));
        ;
        throw new InvalidOperationException(errorMessage);
    }

    private ActionContext GetActionContext()
    {
        var httpContext = new DefaultHttpContext
                          {
                              RequestServices = _serviceProvider
                          };
        return new ActionContext(httpContext, new RouteData(), new ActionDescriptor());
    }
}
```

使用方式

```cs
@page
@inject IHttpContextAccessor HttpContextAccessor
@inject RazorPartialToStringRenderer RazorPartialToStringRenderer
@{
    Layout = null;
}

@functions
{
    public async Task<IActionResult> OnPost()
    {
        // 指定路徑的方式
        // 1. 從專案根目錄開始，指定 cshtml 完整路徑
        // 2. 指定主檔名，會從以下指定的地方搜尋
        //    /Pages/Shared/
        //    /Views/Shared/
        var pageHtml = await RazorPartialToStringRenderer.RenderPartialToStringAsync("/Pages/Test4.cshtml", "Hello World !");

        return new JsonResult(new
                              {
                                  Html = pageHtml,
                                  Data = new
                                         {
                                             Id = 1,
                                             Name = "A",
                                         }
                              });
    }
}
```