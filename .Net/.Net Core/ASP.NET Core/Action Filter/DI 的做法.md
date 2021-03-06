# [DI 的做法](https://docs.microsoft.com/en-us/aspnet/core/mvc/controllers/filters#dependency-injection)

## TypeFilterAttribute

## IFilterFactory

## ServiceFilterAttribute

### 範例一

假設在 Action 上要加這段 Action Filter

```csharp
public class TestActionFilter : ActionFilterAttribute
{
    private readonly IMemoryCache _memoryCache;

    public TestActionFilter(IMemoryCache memoryCache)
    {
        _memoryCache = memoryCache;
    }

    public override void OnActionExecuting(ActionExecutingContext context)
    {

    }
}

```

則在 Startup.ConfigureServices() 中要加上

以下以 mvc 的角度來切入

```csharp
services.AddControllersWithViews(options =>
                                    {
                                        options.Filters.Add(typeof(TestActionFilter));
                                    });

services.AddScoped<TestActionFilter>();

```

那麼在 Action 上，就可以用以下語法

```csharp
[HttpPost]
[ServiceFilter(typeof(TestActionFilter))]
[ValidateAntiForgeryToken]
public async Task<IActionResult> PostLogin(LoginFormDto dto)
{

}
```
