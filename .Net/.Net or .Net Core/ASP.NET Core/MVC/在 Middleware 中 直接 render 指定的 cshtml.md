# 在 Middleware 中 直接 render 指定的 cshtml


```cs
public class SpaMiddleware
{
    private readonly RequestDelegate _next;

    public SpaMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task Invoke(HttpContext context)
    {
        await _next.Invoke(context);

        if (context.Response.StatusCode == (int)HttpStatusCode.NotFound // 該資源不存在
         && !Path.HasExtension(context.Request.Path.Value)              // 網址最後沒有帶副檔名
         && !(context.Request.Path.Value?.StartsWith("/api") ?? false)) // 網址不是 /api 開頭（不是發送 API 需求）
        {
            context.Response.StatusCode = (int)HttpStatusCode.OK;
            await GetViewResultTask(context, "~/Pages/Index.cshtml");
            return;
        }
    }

    /// <summary>
    /// 以 Asp.Net Core Razor Pages 取得指定的 cshtml 的內容
    /// </summary>
    private Task GetViewResultTask(HttpContext context, string viewName)
    {
        var actionContext = new ActionContext(context, new(), new());
        var viewResult = new ViewResult()
        {
            ViewName = viewName,
        };
        
        return viewResult.ExecuteResultAsync(actionContext);
    }
}
```