# 在 ActionFilter 中設定 ViewBag 的方式

### 範例一

- [DI IHttpContextAccessor 的方式](./../../../Nuget%20Packages/Microsoft.AspNetCore.Http.IHttpContextAccessor/Microsoft.AspNetCore.Http.IHttpContextAccessor.md)
- 此範例使用 [這邊的 ServiceFilterAttribute](./DI%20的做法.md##ServiceFilterAttribute)

建立 BaseController

- 讓 BaseController 可以取出 UserInfoDto 的資料

```csharp
public class BaseController : Controller
{
    protected BaseController(IHttpContextAccessor contextAccessor,
                             IAccountService accountService)
    {
        _contextAccessor = contextAccessor;
    }

    private readonly IHttpContextAccessor _contextAccessor;

    protected readonly IAccountService AccountService;

    protected IPAddress IPAddress => _contextAccessor.HttpContext.Connection.RemoteIpAddress;

    protected Guid? UserGuid => _contextAccessor.HttpContext.User.Claims
                                                .FirstOrDefault(c => c.Type == CustomClaimTypes.UserGuid)
                                                ?.Value.ToGuid();

    public UserInfoDto UserInfo => AccountService.GetUserInfoFromCache(UserGuid);

    private IIdentity Identity => _contextAccessor.HttpContext.User.Identity;
}
```

Action Filter 的內容

- 進入到 Action Filter 時，已經完成 Controller 的 Constructor 初始化
- 可以轉型成 BaseController 後，從 Property UserInfo 取出使用者資料，兼顧共用 !

```csharp
/// <summary>
/// 給定 UserInfo 的資料至 ViewBag.UserInfo 中
/// </summary>
public class UserInfoViewBagFilter : ActionFilterAttribute
{
    public override void OnActionExecuting(ActionExecutingContext context)
    {
        var baseController = (context.Controller as BaseController);

        if (baseController == null)
        {
            return;
        }

        baseController.ViewBag.UserInfo = baseController.UserInfo;
    }
}
```

