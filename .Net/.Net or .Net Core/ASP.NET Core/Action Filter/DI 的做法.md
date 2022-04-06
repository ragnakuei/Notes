# [DI 的做法](https://docs.microsoft.com/en-us/aspnet/core/mvc/controllers/filters#dependency-injection)


## ServiceFilterAttribute

- 實作 IActionFilter
- 可直接 DI 至 Constructor
- 可用於 Controller
- 無法傳入自訂的參數
- 需 Register Type 至 DI Container

### 範例

```cs
builder.Services.AddScoped<Filter01>();

[ServiceFilter(typeof(Filter01))]
public IActionResult Index()
{
    return View();
}

public class Filter01 : IActionFilter
{
    public Filter01(ILogger<Filter01> logger)
    {
    }

    public void OnActionExecuting(ActionExecutingContext context)
    {
    }

    public void OnActionExecuted(ActionExecutedContext context)
    {
    }
}
```

## TypeFilterAttribute

- 實作 IActionFilter
- 可直接 DI 至 Constructor
- 可用於 Controller
- 可傳入自訂的參數
  - 傳入參數順序：傳入的參數要放最前面，DI 的 instace 放最後面
- 不需 Register Type 至 DI Container

### 範例

```cs
// 不需要
// builder.Services.AddScoped<Filter01>();

// 給定參數至 Arguments object[] 
[TypeFilter(typeof(Filter02), Arguments = new object[] { "arg1", 2 })]
public IActionResult Index()
{
    return View();
}

public class Filter02 : IActionFilter
{
    // 傳入時，用強型別放入傳入參數
    public Filter02(string            obj1,
                    int               obj2,
                    ILogger<Filter02> logger)
    {
    }

    public void OnActionExecuting(ActionExecutingContext context)
    {
    }

    public void OnActionExecuted(ActionExecutedContext context)
    {
    }
}
```

## IFilterFactory



### 範例一

假設在 Action 上要加這段 Action Filter

- ActionFilterAttribute 也可以改為 IActionFilter

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

以下以 mvc 的角度來切入，以下二個註冊方式擇一使用

```csharp
services.AddControllersWithViews(options =>
                                    {
                                        // 全域註冊
                                        options.Filters.Add(typeof(TestActionFilter));
                                    });

// 區域註冊
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
