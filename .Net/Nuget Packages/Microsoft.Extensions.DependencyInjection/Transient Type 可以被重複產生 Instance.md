# 讓 Transient Type 可以被重複產生 Instance

- 避免分不清 Singleton / Scoped Instance 與 Transient Instance
  - 只要是 DI T ，都是 Singleton / Scoped 週期的
  - 只要是 DI Func\<T> ，都是 Singleton / Scoped 週期的
    - 等到需要時，再透過 Invoke() / Value 產生 Instance
- 避免需要在 Service 間處理生命週期的問題，而必須在 DI 註冊階段去詳細辨識彼此的生命週期 !

## 方式一

### IServiceCollectionHelper.cs

-   建立 IServiceCollection 擴充方法
    -   將 T 以 Transient 生命週期註冊
    -   將 Func\<T> 以 Scoped 生命週期註冊

```csharp
public static class IServiceCollectionHelper
{
    public static void AddTransientCustom<T>(this IServiceCollection services, Func<IServiceProvider, T> func = null)
        where T : class
    {
        if (func == null)
        {
            services.AddTransient<T>();
        }
        else
        {
            services.AddTransient<T>(func);
        }

        services.AddScoped<Func<T>>(serviceProvider => () => serviceProvider.GetService<T>());
    }
}
```

### Startup.cs

```csharp
public class Startup
{
    // 略

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddControllersWithViews();

        // 註冊 ServiceA
        services.AddTransientCustom<ServiceA>();
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        // 略
    }
}
```

### ServiceA.cs

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
        // 會在 Request 結束前，確實進行 Dispose !
        _logger.LogInformation("ServiceA Dispose");
    }
}
```

### Controller.cs

- 以 Func\<T> 來 DI Transient 的 Func
- 透過 Func.Invoke() 來從 DI Container 取出不同的 Instance !

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

## 方式二

語意上會比方式一的 Func 更明確 !

### 建立 ITransient\<T>

```csharp
public interface ITransient<T>
{
    T Get { get; }
}

public class Transient<T> : ITransient<T>
{
    private readonly IServiceProvider _serviceProvider;

    public Transient(IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }

    public T Get => _serviceProvider.GetService<T>();
}
```

### IServiceCollectionHelper.cs

```csharp
public static class IServiceCollectionHelper
{
    public static void AddLazyTransient<T>(this IServiceCollection services)
        where T : class
    {
        services.AddTransient<T>();

        services.AddTransient<Transient<T>>();
        services.AddScoped<ITransient<T>>(serviceProvider => serviceProvider.GetService<Transient<T>>());
    }
}
```

### Startup.cs

```csharp
public class Startup
{
    // 略

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddControllersWithViews();

        // 註冊 ServiceA
        services.AddLazyTransient<ServiceA>();
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        // 略
    }
}
```

### ServiceA.cs

與方案一相同

### Controller.cs

- DI ITransient\<T>
- 透過 ITransient.Get 來從 DI Container 取出不同的 Instance !

```csharp
public class HomeController : Controller
{
    private readonly ITransient<ServiceA> _transientServiceA;

    public HomeController(ILogger<HomeController> logger,
                          ITransient<ServiceA>    transientServiceA)
    {
        _logger            = logger;
        _transientServiceA = transientServiceA;
    }

    public IActionResult Index()
    {
        // 需要 Instance 時，就呼叫 ITransient\<T>.Get 來向 DI Container 產生 Instance
        var serviceA1 = _transientServiceA.Get;
        var serviceA2 = _transientServiceA.Get;

        // 可以確實得到不同的 Instance
        var result = serviceA1 == serviceA2;
        return Ok(result);
    }
}
```