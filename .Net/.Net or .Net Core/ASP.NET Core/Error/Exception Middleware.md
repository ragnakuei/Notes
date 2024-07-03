# Exception Middleware

以 Middleware 角度來處理 Exception

```cs
/// <summary>
/// 全域 Exception 處理 Middleware
/// </summary>
public class ExceptionMiddleware
{
    private readonly RequestDelegate              _next;
    private readonly ILogger<ExceptionMiddleware> _logger;

    public ExceptionMiddleware(RequestDelegate              next,
                               ILogger<ExceptionMiddleware> logger)
    {
        _next   = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext httpContext)
    {
        try
        {
            await _next(httpContext);
        }
        catch (Exception ex)
        {
            var isApi = IsApi(httpContext);

            if (isApi)
            {
                await httpContext.RequestServices
                                 .GetRequiredService<WebApiExceptionHandler>()
                                 .Handle(httpContext, ex);
            }
            else
            {
                await httpContext.RequestServices
                                 .GetRequiredService<MvcExceptionHandler>()
                                 .Handle(httpContext, ex);
            }
        }
    }

    private bool IsApi(HttpContext context) => context.Request.Path.StartsWithSegments("/api");
}
```
