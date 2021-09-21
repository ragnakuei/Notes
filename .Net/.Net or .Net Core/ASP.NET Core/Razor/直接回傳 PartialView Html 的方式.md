# 直接回傳 PartialView Html 的方式

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
