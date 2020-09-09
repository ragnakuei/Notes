# 依 Request 條件來給定 Middleware

讓 `/api` 開頭的 request 加上 ExceptionMiddleware，反之，則加上 ExceptionStatusCodePageMiddleware !

```csharp
app.UseWhen(context => context.Request.Path.StartsWithSegments("/api"),
            applicationBuilder => applicationBuilder.UseMiddleware<ExceptionMiddleware>());

app.UseWhen(context => context.Request.Path.StartsWithSegments("/api") == false,
            applicationBuilder => applicationBuilder.UseMiddleware<ExceptionStatusCodePageMiddleware>());
```

仿 HttpStatusCodePage Middleware 的做法

```csharp
public class ExceptionStatusCodePageMiddleware
{
    public ExceptionStatusCodePageMiddleware(RequestDelegate                            next,
                                                ILogger<ExceptionStatusCodePageMiddleware> logger)
    {
        _logger = logger;
        _next   = next;
    }

    private readonly ILogger<ExceptionStatusCodePageMiddleware> _logger;


    private readonly RequestDelegate _next;

    public async Task InvokeAsync(HttpContext httpContext)
    {
        try
        {
            await _next(httpContext);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex.GetLogMessages());

            var code = 500;

            httpContext.Response.Redirect($"/StatusCode?code={code}", true);
        }
    }
}
```
