# Session

[Session and state management in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/app-state#session-state)

[Configure SQL Server Session State In ASP.NET Core](https://www.c-sharpcorner.com/article/configure-sql-server-session-state-in-asp-net-core/)

[範例](https://github.com/ragnakuei/AspNetCoreDistributedSqlServerCacheAndSession)

## 啟用 Session

如果是 Web Api 專案，就要啟用 `IDistributedCache`

> MVC 專案待測：是否可改用 `Distributed SQL Server Cache`

-   [Asp.Net Core MemoryCache](./Cache/MemoryCache.md)
-   [Distributed SQL Server Cache](./Cache/Distributed%20SQL%20Server%20Cache.md)

Startup.ConfigureServices() 加上

- 不額外指定 Cookie 時，會使用 預設的 Cookie 來執行，該 Cookie Name 為 `.AspNetCore.Session`
- 

```csharp
services.AddSession(options =>
                    {
                        // 靠 Cookie 來取得 Session
                        options.Cookie = new CookieBuilder
                                            {
                                                // 如果要額外指定 Cookie ，就必須指定名稱，否則報錯
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
    protected readonly IHttpContextAccessor _contextAccessor;

    public BaseController(IHttpContextAccessor contextAccessor)
    {
        _contextAccessor = contextAccessor;
    }

    public string SessionId => _contextAccessor.HttpContext.Session.Id;
}
```

## 放入及取出資料

```csharp
public class HomeController : BaseController
{

    public HomeController(IHttpContextAccessor contextAccessor)
        : base(contextAccessor)
    {
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

View

```html
<p>ViewBag.SessionId: @(ViewBag.SessionId)</p>
<p>ViewBag.SessionData: @(ViewBag.SessionData)</p>
<p>ViewBag.SessionByteArrayData: @(ViewBag.SessionByteArrayData)</p>
```

## 清除 Session

- Sessiobn.Clear() 會清掉放在 Session 的物件，但不會更改 Session Id !
- 要做到確實達到 Session Id 都變更的情況：就是將原本 Session 產生的 Cookie 設為過期

 >

```csharp
_contextAccessor.HttpContext.Session.Clear();
_contextAccessor.Response.Cookies.Append(".AspNetCore.Session",
                                        string.Empty,
                                        new CookieOptions
                                        {
                                            // Domain      = null,
                                            // Path        = null,
                                            Expires  = DateTimeOffset.Now.AddSeconds(-1),
                                            Secure   = true,
                                            SameSite = SameSiteMode.Strict,
                                            HttpOnly = true,
                                            // MaxAge      = null,
                                            // IsEssential = false
                                        });
```
