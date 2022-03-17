# Microsoft.AspNetCore.Http.IHttpContextAccessor

## 要 DI 的設定

```csharp
services.AddHttpContextAccessor();
```


注意：

從 IHttpContextAccessor 取出 Current HttpContext 時，不要在 DI IHttpContextAccessor 就取出 HttpContext


```cs
public class LogService
{
    private readonly ILogger<LogService>  _logger;
    private readonly HttpContext          _httpContext;

    public LogService(ILogger<LogService>   logger,
                      IHttpContextAccessor httpContextAccessor)
    {
        _logger      = logger;
        _httpContext = httpContextAccessor.HttpContext;
    }

    public void Log()
    {
        // 這邊取出的 _httpContext 必定是 null !
    }
}
```

要改用下面的語法：

```cs
public class LogService
{
    private readonly ILogger<LogService>  _logger;
    private readonly IHttpContextAccessor _httpContextAccessor;

    public LogService(ILogger<LogService>  logger,
                      IHttpContextAccessor httpContextAccessor)
    {
        _logger              = logger;
        _httpContextAccessor = httpContextAccessor;
    }

    public void Log()
    {
        // 這邊再以 _httpContextAccessor.HttpContext 來取出 Current HttpContext !
    }
}
```