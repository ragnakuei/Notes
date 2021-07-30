# 同一 Site 前後台分別登入管理機制

概念
- 調整原本的 FormAuthentication 功能
- 加上自行拆分前台、後台用的 Cookie Schema
- 每個 request 都去解析 Cookie 取出需要的資料，放至 Identity 內
- BaseController 從 Identity 取出 前台、後台 各自需要的 UserInfoDto

注意事項：
- 不要用 Session 存物件，因為 前台或後台 登出時，會清 Session
- 可以改用 MemoryCache

## 呼叫流程

- 登入，呼叫 BaseController.Login(cookieName)
  - 前後台為不同的 cookieName，同時前後台分別管理
  - 登入時，就依照 cookieName 來將資料寫入
- 下次 Request 先執行 Global.asax.cs > Application_AuthenticateRequest()
  - 同時取出前台、後台的 cookie
  - 驗証登入資料是否有變更
    - 如果有變更，則直接 Redirect 進行登出
  - 把前台、後台資料以 Dictionary 結合，寫入該次 User.Identity 內
- BaseController
  - 從 User.Identity 取出前後台的登入資料

## BaseController

```csharp
public abstract class BaseController : Controller
{
    protected BaseController()
    {
        // 下面這行語法，上正式機 + IIS 時，就會報錯，出現轉型失敗的問題
        // var userInfoDtos = ((FormsIdentity)System.Web.HttpContext.Current?.User?.Identity)?.Ticket?.UserData?.ParseJson<Dictionary<string, UserInfoDto>>();

        // if (userInfoDtos?.Count > 0)
        // {
        //     FrontendUserInfoDto = userInfoDtos.GetValueOrDefault(CookieNameConst.Frontend);
        //     ManageUserInfoDto   = userInfoDtos.GetValueOrDefault(CookieNameConst.Manage);
        // }

        // 目前測試，用這個語法就會正常 !
        if (System.Web.HttpContext.Current?.User?.Identity is FormsIdentity formsIdentity)
        {
            var userInfoDtos = formsIdentity.Ticket?.UserData?.ParseJson<Dictionary<string, UserInfoDto>>();

            if (userInfoDtos?.Count > 0)
            {
                FrontendUserInfoDto = userInfoDtos.GetValueOrDefault(CookieNameConst.Frontend);
                ManageUserInfoDto   = userInfoDtos.GetValueOrDefault(CookieNameConst.Manage);
            }
        }
    }

    protected UserInfoDto FrontendUserInfoDto { get; }

    protected UserInfoDto ManageUserInfoDto { get; }

    protected void BaseLogin(UserInfoDto userInfoDto, string cookieName)
    {
        Session.Clear();

        var ticket = new FormsAuthenticationTicket(version: 1,
                                                    name: userInfoDto.Name,
                                                    issueDate: DateTime.Now,
                                                    expiration: DateTime.Now.AddMinutes(30),
                                                    isPersistent: false,
                                                    userData: userInfoDto.ToJson(),
                                                    cookiePath: FormsAuthentication.FormsCookiePath);

        var encTicket = FormsAuthentication.Encrypt(ticket);
        var httpCookie = new HttpCookie(cookieName, encTicket)
                            {
                                HttpOnly = true,
                                Secure   = FormsAuthentication.RequireSSL,
                            };
        Response.Cookies.Add(httpCookie);
    }

    protected void BaseLogout(string cookieName)
    {
        FormsAuthentication.SignOut();

        var deleteCookie = new HttpCookie( cookieName );
        deleteCookie.Expires = DateTime.Now.AddDays( -1 );
        Response.Cookies.Add( deleteCookie );

        Session.Clear();
    }
}
```

## Global.asax.cs

```csharp
public class MvcApplication : System.Web.HttpApplication
{
    // ... 僅列出相關部份，其餘略

    protected void Application_AuthenticateRequest(object sender, EventArgs e)
    {
        var frontendUserInfoDto = GetAuthenticationFromCookie(FormsAuthentication.FormsCookieName + CookieNameConst.Frontend);
        if (TryValidateFrontendUserInfoDto(frontendUserInfoDto, out frontendUserInfoDto) == false)
        {
            HttpContext.Current.Response.Redirect("/Account/Logout");
        }

        var manageUserInfoDto = GetAuthenticationFromCookie(FormsAuthentication.FormsCookieName + CookieNameConst.Manage);
        if (TryValidateManageUserInfoDto(manageUserInfoDto, out manageUserInfoDto) == false)
        {
            HttpContext.Current.Response.Redirect("/Manage/Account/Logout");
        }

        if (frontendUserInfoDto != null
            || manageUserInfoDto   != null)
        {
            var ticket = new FormsAuthenticationTicket(version: 1,
                                                        frontendUserInfoDto?.Account + manageUserInfoDto?.Account,
                                                        issueDate: DateTime.Now,
                                                        expiration: DateTime.Now.AddMinutes(30),
                                                        isPersistent: false,
                                                        userData: new Dictionary<string, UserInfoDto>
                                                                    {
                                                                        [CookieNameConst.Frontend] = frontendUserInfoDto,
                                                                        [CookieNameConst.Manage]   = manageUserInfoDto,
                                                                    }.ToJson(),
                                                        cookiePath: FormsAuthentication.FormsCookiePath);
            var identity = new FormsIdentity(ticket);

            var roles = new[] { frontendUserInfoDto?.Role, manageUserInfoDto?.Role }
                        .Where(r => r.IsNullOrWhiteSpace() == false)
                        .ToArray();

            HttpContext.Current.User = new GenericPrincipal(identity, roles);
        }
    }

    /// <summary>
    /// 驗証前端使用者
    /// </summary>
    private bool TryValidateFrontendUserInfoDto(UserInfoDto frontendUserInfoDto, out UserInfoDto userInfoDto)
    {
        if (frontendUserInfoDto != null)
        {
            userInfoDto = new FrontendAccountRepository().GetUserByGuid(frontendUserInfoDto.Guid.GetValueOrDefault());

            return userInfoDto.Equals(frontendUserInfoDto);
        }

        userInfoDto = null;

        return true;
    }

    /// <summary>
    /// 驗証後端使用者
    /// </summary>
    private bool TryValidateManageUserInfoDto(UserInfoDto manageUserInfoDto, out UserInfoDto userInfoDto)
    {
        if (manageUserInfoDto != null)
        {
            userInfoDto = new AccountRepository().GetUserByGuid(manageUserInfoDto.Guid.GetValueOrDefault());

            return userInfoDto.Equals(manageUserInfoDto);
        }

        userInfoDto = null;

        return true;
    }

    private UserInfoDto GetAuthenticationFromCookie(string cookieName)
    {
        var authCookie = HttpContext.Current.Request.Cookies[cookieName];

        if (authCookie == null)
        {
            return null;
        }

        var cookieValue = authCookie.Value;

        if (cookieValue.IsNullOrWhiteSpace())
        {
            return null;
        }

        var ticket = FormsAuthentication.Decrypt(cookieValue);

        var userInfoDto = ticket.UserData.ParseJson<UserInfoDto>();

        return userInfoDto;
    }
}
```
