# 透過 MVC 的功能來渲染 Razor Page String.md

-   在 Middleware 中，透過 MVC 的功能來渲染 Razor Page
-   會直接將 View Render 的結果寫入至 Response Body 中
-   asp-append-version="true" 功能，會在檔案內容變更後，其 version 才會變更
-   如果原本的專案為 Asp.Net Core Web API, 需要加入 MVC 的功能

    ```cs
    // builder.Services.AddControllers();

    // 為了讓 SPA 可以使用 MVC 的功能來渲染 Razor Page
    builder.Services.AddControllersWithViews();
    ```

```cs
using System.Net;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.Razor;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.ViewFeatures;

namespace AspNetCoreWebAPI_Vue.Infra;

public class SpaMiddleware
{
    private readonly RequestDelegate   _next;
    private readonly IRazorViewEngine  _razorViewEngine;
    private readonly ITempDataProvider _tempDataProvider;

    public SpaMiddleware(RequestDelegate   next,
                         IRazorViewEngine  razorViewEngine,
                         ITempDataProvider tempDataProvider)
    {
        _next             = next;
        _razorViewEngine  = razorViewEngine;
        _tempDataProvider = tempDataProvider;
    }

    public async Task Invoke(HttpContext context)
    {
        await _next.Invoke(context);

        if (context.Response.StatusCode == (int)HttpStatusCode.NotFound // 該資源不存在
         && !Path.HasExtension(context.Request.Path.Value)              // 網址最後沒有帶副檔名
         && !(context.Request.Path.Value?.StartsWith("/api") ?? false)) // 網址不是 /api 開頭（不是發送 API 需求）
        {
            // 設定 response body
            // 使用 MVC 的功能來渲染 Razor Page
            await RenderView(context, "~/Views/Home/Index.cshtml");
            return;
        }
    }

    private async Task RenderView(HttpContext context, string viewName)
    {
        var viewEngineResult = _razorViewEngine.GetView(null, viewName, false);

        if (!viewEngineResult.Success)
        {
            // View 不存在，可在此處處理
            context.Response.StatusCode = 404;
            await context.Response.WriteAsync("View not found.");
            return;
        }

        var view = viewEngineResult.View;

        var viewData = new ViewDataDictionary(new EmptyModelMetadataProvider(), new ModelStateDictionary())
                       {
                           Model = null
                       };

        var tempData = new TempDataDictionary(context, _tempDataProvider);

        using (var writer = new StringWriter())
        {
            var viewContext = new ViewContext()
                              {
                                  HttpContext = context,
                                  RouteData   = context.GetRouteData(),
                                  ViewData    = viewData,
                                  TempData    = tempData,
                                  Writer      = writer
                              };

            await view.RenderAsync(viewContext);

            var renderedView = writer.ToString();

            context.Response.StatusCode  = (int)HttpStatusCode.OK;
            context.Response.ContentType = "text/html";
            await context.Response.WriteAsync(renderedView);
        }
    }
}}
```
