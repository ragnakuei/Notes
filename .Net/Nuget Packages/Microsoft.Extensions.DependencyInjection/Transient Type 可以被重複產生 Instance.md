# 讓 Transient Type 可以被重複產生 Instance

- 避免分不清 Singleton / Scoped Instance 與 Transient Instance
  - 只要是 DI T ，都是 Singleton / Scoped 週期的
  - 只要是 DI Func\<T> ，都是 Singleton / Scoped 週期的
    - 等到需要時，再 Invoke()
- 避免需要在 Service 間處理生命週期的問題，而必須在 DI 註冊階段去詳細辨識彼此的生命週期 !

## IServiceCollectionHelper.cs

-   建立 IServiceCollection 擴充方法
    -   將 T 以 Transient 生命週期註冊
    -   將 Func\<T> 以 Scoped 生命週期註冊

```csharp
public static class IServiceCollectionHelper
{
    public static void AddTransientCustom<T>(this IServiceCollection services)
        where T : class
    {
        services.AddTransient<T>();
        services.AddScoped<Func<T>>(serviceProvider => () => serviceProvider.GetService<T>());
    }
}
```

## Startup.cs

```csharp
public class Startup
{
    // 略

    // This method gets called by the runtime. Use this method to add services to the container.
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddControllersWithViews();

        // 註冊 ServiceA
        services.AddTransientCustom<ServiceA>();
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        // 略
    }
}
```

## ServiceA.cs

```csharp
public class ServiceA : IDisposable
{
    private readonly ILogger<ServiceA> _logger;

    public ServiceA(ILogger<ServiceA> logger)
    {
        _logger = logger;
    }

    public void Dispose()
    {
        _logger.LogInformation("ServiceA Dispose");
    }
}
```

## Controller.cs

- 以 Func\<T> 來 DI Transient 的 Func
- 透過 Func.Invoke() 來重複從 DI Container 取出不同的 Instance !

```csharp
public class HomeController : Controller
{
    private readonly Func<ServiceA> _lazyServiceA;

    public HomeController(ILogger<HomeController> logger,

                          // 以 Func\<T> 的方式來 DI
                          Func<ServiceA> lazyServiceA)
    {
        _logger       = logger;
        _lazyServiceA = lazyServiceA;
    }

    public IActionResult Index()
    {
        // 需要 Instance 時，就呼叫 Func\<T>.Invoke() 來向 DI Container 產生 Instance
        var serviceA1 = _lazyServiceA.Invoke();
        var serviceA2 = _lazyServiceA.Invoke();

        // 可以確實得到不同的 Instance
        var result = serviceA1 == serviceA2;
        return Ok(result);
    }
}
```
