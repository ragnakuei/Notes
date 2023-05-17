# 透過 MVC 的功能來渲染 Razor Page.md

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
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Infrastructure;

namespace AspNetCoreWebAPIVue.Infra;

public class SpaMiddleware
{
    private readonly RequestDelegate  _next;

    public SpaMiddleware(RequestDelegate  next)
    {
        _next            = next;
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
            await GetViewResultTask(context, "~/Views/Home/Index.cshtml");
            return;
        }
    }

    private Task GetViewResultTask(HttpContext context, string viewName)
    {
        var viewResult = new ViewResult()
                         {
                             ViewName = viewName
                         };

        var executor  = context.RequestServices.GetRequiredService<IActionResultExecutor<ViewResult>>();
        var routeData = context.GetRouteData();
        var actionContext = new ActionContext(context,
                                              routeData,
                                              new Microsoft.AspNetCore.Mvc.Abstractions.ActionDescriptor());

        context.Response.StatusCode = (int)HttpStatusCode.OK;
        return executor.ExecuteAsync(actionContext, viewResult);
    }
}
```
