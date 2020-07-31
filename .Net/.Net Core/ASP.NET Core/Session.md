# Session

[Session and state management in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/app-state#session-state)

[Configure SQL Server Session State In ASP.NET Core](https://www.c-sharpcorner.com/article/configure-sql-server-session-state-in-asp-net-core/)

[範例](https://github.com/ragnakuei/AspNetCoreDistributedSqlServerCacheAndSession)

## 啟用 Session

啟用 `IDistributedCache`

-   [Distributed SQL Server Cache](./Cache/Distributed%20SQL%20Server%20Cache.md)

Startup.ConfigureServices() 加上

```csharp
services.AddSession(options =>
                    {
                        // 靠 Cookie 來取得 Session
                        options.Cookie = new CookieBuilder
                                            {
                                                Name = "Test.Session"
                                            };
                        options.IdleTimeout = TimeSpan.FromMinutes(10);
                    });

// 為了要可以 DI IHttpContextAccessor，從取得的 instance 來取得 Session instance
services.AddHttpContextAccessor();
```

Startup.Configure() 加上

```csharp
app.UseSession();
```

## 取出 SessionId

DI [IHttpContextAccessor](./../../Nuget%20Packages/Microsoft.AspNetCore.Http.IHttpContextAccessor/Microsoft.AspNetCore.Http.IHttpContextAccessor.md)

```csharp
public class BaseController : ControllerBase
{
    private readonly IHttpContextAccessor _contextAccessor;

    public BaseController(IHttpContextAccessor contextAccessor)
    {
        _contextAccessor = contextAccessor;
    }

    public string SessionId => _contextAccessor.HttpContext.Session.Id;
}
```

## 放入及取出資料

```csharp
public class HomeController : Controller
{
    private readonly IHttpContextAccessor _contextAccessor;

    public HomeController(IHttpContextAccessor contextAccessor)
    {
        _contextAccessor = contextAccessor;
    }

    public IActionResult Index()
    {
        ViewBag.SessionId = SessionId;

        // 以字串方式儲存 & 取出
        _contextAccessor.HttpContext.Session.SetString("name", "Kuei");
        ViewBag.SessionData = _contextAccessor.HttpContext.Session.GetString("name");

        // 以 byte[] 方式儲存 & 取出
        _contextAccessor.HttpContext.Session.Set("Test", Encoding.UTF8.GetBytes(DateTime.Now.ToString()));
        ViewBag.SessionByteArrayData = Encoding.UTF8.GetString(_contextAccessor.HttpContext.Session.Get("Test"));

        return View();
    }
}
```
