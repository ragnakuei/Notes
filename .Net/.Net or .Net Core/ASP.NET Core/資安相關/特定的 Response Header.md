# 特定的 Response Header

```cs
/// <summary>
/// 移除不必要的 Response Header
/// </summary>
public class RemoveResponseHeaderMiddleware
{
    public RemoveResponseHeaderMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    private readonly RequestDelegate _next;

    public async Task Invoke(HttpContext context)
    {
        if (context.Response.Headers.ContainsKey("X-Xss-Protection"))
        {
            context.Response.Headers.Remove("X-Xss-Protection");
            context.Response.Headers.Remove("X-Frame-Options");
            context.Response.Headers.Remove("X-Content-Type-Options");
            context.Response.Headers.Remove("Referrer-Policy");
            context.Response.Headers.Remove("Feature-Policy");
        }

        context.Response.Headers.Add("X-Xss-Protection",       "1");
        context.Response.Headers.Add("X-Frame-Options",        "DENY");
        context.Response.Headers.Add("X-Content-Type-Options", "nosniff");
        context.Response.Headers.Add("Referrer-Policy",        "no-referrer");
        context.Response.Headers.Add("Feature-Policy",         "accelerometer 'none'; camera 'none'; geolocation 'none'; gyroscope 'none'; magnetometer 'none'; microphone 'none'; payment 'none'; usb 'none'");

        await _next(context);
    }
}
```