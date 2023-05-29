# 直接回傳 PartialView Html 的方式

## 方式一

建立 Extension

```csharp
public static class ControllerExtensions
{
    public static async Task<string> RenderViewAsync<TModel>(this Controller controller, string viewName, TModel model, bool partial = false)
    {
        if (string.IsNullOrEmpty(viewName))
        {
            viewName = controller.ControllerContext.ActionDescriptor.ActionName;
        }

        controller.ViewData.Model = model;

        using (var writer = new StringWriter())
        {
            IViewEngine      viewEngine = controller.HttpContext.RequestServices.GetService(typeof(ICompositeViewEngine)) as ICompositeViewEngine;
            ViewEngineResult viewResult = viewEngine.FindView(controller.ControllerContext, viewName, !partial);

            if (viewResult.Success == false)
            {
                return $"A view with the name {viewName} could not be found";
            }

            ViewContext viewContext = new ViewContext(
                                                        controller.ControllerContext,
                                                        viewResult.View,
                                                        controller.ViewData,
                                                        controller.TempData,
                                                        writer,
                                                        new HtmlHelperOptions()
                                                        );

            await viewResult.View.RenderAsync(viewContext);

            return writer.GetStringBuilder().ToString();
        }
    }
}
```

使用方式

```csharp
[HttpPost, Route("api/[Controller]/[Action]")]
[ValidateAntiForgeryToken]
public async Task<IActionResult> GetList(PageInfoDto dto)
{
    var dtoWithVenders = await _venderService.GetListAsync(dto);

    var html = await this.RenderViewAsync("_VenderList", dtoWithVenders);

    // TODO:Add LogRecord

    return Ok(new ResponseDto
                {
                    PageInfo = dto,
                    Data     = html
                });
}
```

## 方式二

必須指定其副檔名為 .cshtml

```cs
public class BaseController : Controller
{
    /// <summary>
    /// Render 指定的 View 及 Model，該 View 在 Views/ControllerName 的資料夾下
    /// </summary>
    /// <param name="viewName">View.cshtml 的主檔名，不包含副檔名</param>
    /// <param name="partial"></param>
    /// <returns></returns>
    protected async Task<string> RenderViewByFindViewAsync<TModel>(string viewName, TModel model, bool partial = true)
    {
        if (string.IsNullOrEmpty(viewName))
        {
            viewName = ControllerContext.ActionDescriptor.ActionName;
        }

        ViewData.Model = model;

        using (var writer = new StringWriter())
        {
            IViewEngine      viewEngine = HttpContext.RequestServices.GetService(typeof(ICompositeViewEngine)) as ICompositeViewEngine;
            ViewEngineResult viewResult = viewEngine.FindView(ControllerContext, viewName, !partial);

            if (viewResult.Success == false)
            {
                return $"A view with the name {viewName} could not be found";
            }

            ViewContext viewContext = new ViewContext(
                                                      ControllerContext,
                                                      viewResult.View,
                                                      ViewData,
                                                      TempData,
                                                      writer,
                                                      new HtmlHelperOptions()
                                                     );

            await viewResult.View.RenderAsync(viewContext);

            return writer.GetStringBuilder().ToString();
        }
    }

    /// <summary>
    /// Render 指定的 View，該 View 在 Views/ControllerName 的資料夾下
    /// </summary>
    /// <param name="viewName">View.cshtml 的主檔名，不包含副檔名</param>
    /// <param name="partial"></param>
    /// <returns></returns>
    protected async Task<string> RenderViewByFindViewAsync(string viewName, bool partial = true)
    {
        if (string.IsNullOrEmpty(viewName))
        {
            viewName = ControllerContext.ActionDescriptor.ActionName;
        }

        using (var writer = new StringWriter())
        {
            IViewEngine      viewEngine = HttpContext.RequestServices.GetService(typeof(ICompositeViewEngine)) as ICompositeViewEngine;
            ViewEngineResult viewResult = viewEngine.FindView(ControllerContext, viewName, !partial);

            if (viewResult.Success == false)
            {
                return $"A view with the name {viewName} could not be found";
            }

            ViewContext viewContext = new ViewContext(
                                                      ControllerContext,
                                                      viewResult.View,
                                                      ViewData,
                                                      TempData,
                                                      writer,
                                                      new HtmlHelperOptions()
                                                     );

            await viewResult.View.RenderAsync(viewContext);

            return writer.GetStringBuilder().ToString();
        }
    }

    /// <summary>
    /// Render 指定的 View
    /// </summary>
    /// <param name="viewName">
    /// 範例：~/Views/Home/home.cshtml
    /// <remarks>不能用 .js </remarks>
    /// </param>
    /// <param name="partial"></param>
    /// <returns></returns>
    protected async Task<string> RenderViewByGetViewAsync(string viewName, bool partial = true)
    {
        if (string.IsNullOrEmpty(viewName))
        {
            viewName = ControllerContext.ActionDescriptor.ActionName;
        }

        using (var writer = new StringWriter())
        {
            IViewEngine viewEngine = HttpContext.RequestServices.GetService(typeof(ICompositeViewEngine)) as ICompositeViewEngine;

            ViewEngineResult viewResult = viewEngine.GetView(viewName, viewName, !partial);

            if (viewResult.Success == false)
            {
                return $"A view with the name {viewName} could not be found";
            }

            ViewContext viewContext = new ViewContext(ControllerContext,
                                                      viewResult.View,
                                                      ViewData,
                                                      TempData,
                                                      writer,
                                                      new HtmlHelperOptions());

            await viewResult.View.RenderAsync(viewContext);

            return writer.GetStringBuilder().ToString();
        }
    }
    
    /// <summary>
    /// Render 指定的 View 及 Model
    /// </summary>
    /// <param name="viewName">
    /// 範例：~/Views/Home/home.cshtml
    /// <remarks>不能用 .js </remarks>
    /// </param>
    /// <param name="partial"></param>
    /// <returns></returns>
    protected async Task<string> RenderViewByGetViewAsync<TModel>(string viewName, TModel model, bool partial = true)
    {
        if (string.IsNullOrEmpty(viewName))
        {
            viewName = ControllerContext.ActionDescriptor.ActionName;
        }
        
        ViewData.Model = model;
        
        using (var writer = new StringWriter())
        {
            IViewEngine viewEngine = HttpContext.RequestServices.GetService(typeof(ICompositeViewEngine)) as ICompositeViewEngine;

            ViewEngineResult viewResult = viewEngine.GetView(viewName, viewName, !partial);

            if (viewResult.Success == false)
            {
                return $"A view with the name {viewName} could not be found";
            }

            ViewContext viewContext = new ViewContext(ControllerContext,
                                                      viewResult.View,
                                                      ViewData,
                                                      TempData,
                                                      writer,
                                                      new HtmlHelperOptions());

            await viewResult.View.RenderAsync(viewContext);

            return writer.GetStringBuilder().ToString();
        }
    }
}
```

```cs
// 使用方式

// 1. router 為 Views/ControllerName/router.cshtml
ViewBag.Host = _host;
var fileContent = await RenderViewByFindViewAsync("router", true);


// 2. 指定 View 的路徑
var fileContent = await RenderViewByGetViewAsync("~/Views/Home/home.cshtml");

```