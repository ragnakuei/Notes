# Status Code Page

## [UseStatusCodePagesWithRedirects](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/error-handling#usestatuscodepageswithredirects)

以 Redirect 的方式來轉至指定固定

-   可用於 Route 都 Mapping 不到時，轉到 NotFoundPage !

```csharp
app.UseStatusCodePagesWithRedirects("/StatusCode?code={0}");
```

```csharp
public class StatusCodeController : BaseController
{
    [HttpGet]
    [Route("[Controller]")]
    public async Task<IActionResult> Index(HttpStatusCode code)
    {
        switch (code)
        {
            case HttpStatusCode.NotFound:
                return View("NotFound");
            case HttpStatusCode.InternalServerError:
            default:
                return View("InternalServerError");
        }
    }
}
```

## [UseStatusCodePagesWithReExecute](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/error-handling#usestatuscodepageswithreexecute)

TODO: Study

## [Disable status code pages](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/error-handling#disable-status-code-pages)
