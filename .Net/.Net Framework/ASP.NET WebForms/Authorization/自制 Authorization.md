# 自制 Authorization

## [範例](https://github.com/ragnakuei/AspNetSample)

- 讓一個網站可以保留多個登入狀態
  - Site - 一個 Site 就會有一個登入狀態
  - Roles - 限制該 Site 下，限制要哪些 Role 才允許進入

Web.config

-   設定 unauthentication 後的 login url

    ```xml
    <system.web>
        <authentication mode="Forms">
            <forms loginUrl="/Account/Login.aspx" timeout="2880" />
        </authentication>
    </system.web>
    ```

Global.asax.cs

-   指定判斷流程

    ```csharp
    protected void Application_BeginRequest(object sender, EventArgs e)
    {
        AuthoirzeSiteRoles(actualPath);
    }

    /// <summary>
    /// 驗証 Page CustomAuthorizeAttribute 所給定的 Site、Roles
    /// </summary>
    private void AuthoirzeSiteRoles(string actualPath)
    {
        var authorizeResult = new CustomAuthorizeService(HttpContext.Current).AuthorizeForAspx(actualPath, out var userInfoDto);

        switch (authorizeResult)
        {
            case true:
                HttpContext.Current.Items.Add(HttpContextItemConst.UserInfo, userInfoDto);
                break;
            case false:
                // 這邊給定 Http Status Code 401 後，才會走回原本 Asp.Net 的 Unauthentication 的流程
                HttpContext.Current.Response.StatusCode = 401;
                break;
        }
    }
    ```

CustomAuthorizeService.cs

```csharp
public class CustomAuthorizeService
{
    private readonly HttpContext _httpContext;

    /// <summary>
    /// Key：aspx 路徑
    /// <remarks>程式一開始執行時，就會給定</remarks>
    /// </summary>
    private static ConcurrentDictionary<string, PageDto> _pageMapByPath = new ConcurrentDictionary<string, PageDto>();

    /// <summary>
    /// Key：HttpHandler Type
    /// <remarks>呼叫過的才會被加入</remarks>
    /// </summary>
    private static ConcurrentDictionary<Type, CustomAuthorizeAttribute> _pageMapByType = new ConcurrentDictionary<Type, CustomAuthorizeAttribute>();

    static CustomAuthorizeService()
    {
        InitialPageDto();
    }

    private static void InitialPageDto()
    {
        var assembly = Assembly.GetExecutingAssembly();

        assembly.GetTypes()
                .Where(t => typeof(Page).IsAssignableFrom(t))
                .Select(t => new PageDto
                                {
                                    Path            = string.Format("/{0}.aspx", t.FullName.TrimStart("WebFormSample.").Replace(".", "/").ToLower()),
                                    CustomAuthorize = t.GetCustomAttribute<CustomAuthorizeAttribute>(),
                                })
                .ForEach(pageDto => _pageMapByPath.TryAdd(pageDto.Path, pageDto));
    }

    public CustomAuthorizeService(HttpContext httpContext)
    {
        _httpContext = httpContext;
    }

    /// <summary>
    /// 給 Global.asax.cs 用
    /// </summary>
    public bool? AuthorizeForAspx(string actualPath, out UserInfoDto userInfoDto)
    {
        userInfoDto = null;

        var customAuthorize = _pageMapByPath.GetValueOrDefault(actualPath.ToLower())?.CustomAuthorize;

        return Authorize(ref userInfoDto, customAuthorize);
    }

    /// <summary>
    /// 給 HttpHandler 用
    /// </summary>
    public bool? AuthorizeForAshx(Type type, out UserInfoDto userInfoDto)
    {
        userInfoDto = null;

        var customAuthorize = _pageMapByType.GetValueOrDefault(type);

        if (customAuthorize == null)
        {
            customAuthorize = type.GetCustomAttribute<CustomAuthorizeAttribute>();

            _pageMapByType.TryAdd(type, customAuthorize);
        }

        return Authorize(ref userInfoDto, customAuthorize);
    }

    private bool? Authorize(ref UserInfoDto userInfoDto, CustomAuthorizeAttribute customAuthorize)
    {
        if (customAuthorize == null
            || customAuthorize.Site.IsNullOrWhiteSpace()
            || customAuthorize.Roles?.Length > 0 == false)
        {
            // 不做 Authorize
            return null;
        }

        var userInfoMap = new MultipleLoginService(_httpContext.Request, _httpContext.Response).GetUserInfoMap();

        if (userInfoMap?.Count > 0)
        {
            var userGuid = userInfoMap.GetValueOrDefault(customAuthorize?.Site);

            userInfoDto = new AccountService().GetUserInfo(userGuid);

            var userInfoDtoRoles = userInfoDto?.Site.Roles.Select(r => r.Value).ToHashSet45();

            if (userGuid                != null
                && userInfoDtoRoles?.Count > 0
                && userInfoDto.Site.Value  == customAuthorize.Site
                && customAuthorize.Roles.Any(r => userInfoDtoRoles.Contains(r)))
            {
                return true;
            }
        }

        return false;
    }
}
```

CustomAuthorizeAttribute.cs

-   用來放在 Page 的 Attribute，指定 Site 及 Roles

```csharp
public class CustomAuthorizeAttribute : Attribute
{
    public CustomAuthorizeAttribute(string site, params string[] roles)
    {
        Site  = site;
        Roles = roles;
    }

    public string Site { get; }

    public string[] Roles { get; }
}
```

### aspx 部份

User/Index.aspx.cs

```csharp
[CustomAuthorize(SiteConst.Front, RoleConst.User)]
public partial class Index : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        (Page.Master as BaseMasterPage).UserInfo = this.UserInfo;
    }
}
```

### ashx 部份

BaseHttpHandler.cs

```csharp
public abstract class BaseHttpHandler : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        ResponseDto responseData = null;

        try
        {
            // Authorize
            var authorizeResult = new CustomAuthorizeService(HttpContext.Current).AuthorizeForAshx(this.GetType(), out var userInfoDto);
            if (authorizeResult == false)
            {
                throw new UnauthorizedAccessException();
            }

            UserInfoDto = userInfoDto;

            CurrentContext = context;

            context.Response.ContentType = "application/json";

            responseData = HandlerRequest();
        }
        catch (HttpAntiForgeryException e)
        {
            responseData = new ResponseDto
                           {
                               Message = "Antifogery Token 驗證失敗",
                               IsValid = false
                           };
        }
        catch (ValidateFormFailedException e)
        {
            responseData = new ResponseDto
                           {
                               Message        = ClassLibrary.i18n.Resource.ValidateFormFailed,
                               ErrorCode      = ErrorCode.E400003,
                               ValidateResult = e.ValidateResult,
                               IsValid        = false,
                               Dto            = e.Dto
                           };
        }
        catch (ErrorCodeException e)
        {
            responseData = new ResponseDto
                           {
                               IsValid   = false,
                               Message   = e.Message,
                               ErrorCode = e.ErrorCode,
                               Dto       = e.Data
                           };
        }
        catch (UnauthorizedAccessException e)
        {
            responseData = new ResponseDto
                           {
                               Message = "未授權",
                               IsValid = false
                           };
        }
        catch (Exception e)
        {
            responseData = new ResponseDto
                           {
                               Message = ClassLibrary.i18n.Resource.UnExpectedErrorOccured + " " + e.Message,
                               IsValid = false
                           };
        }

        HttpContext.Current.Response.Write(responseData.ToJson());
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.End();
    }

    protected UserInfoDto UserInfoDto { get; set; }

    protected abstract ResponseDto HandlerRequest();

    protected HttpContext CurrentContext { get; set; }

    public bool IsReusable { get; } = true;
}
```
xxx.ashx

- 主要是看 CustomAuthorize 的給定，與 aspx 一致

```csharp
[CustomAuthorize(SiteConst.Manage, RoleConst.Manager)]
public class Edit : BaseHttpHandler
{
    protected override ResponseDto HandlerRequest()
    {
        Dto dto = null;

        using (var stream = CurrentContext.Request.InputStream)
        using (var sr = new StreamReader(stream))
        {
            dto = sr.ReadToEnd().ParseJson<Dto>();
        }

        new ValidatorDto().Validate(null, dto);

        dto.UpdatorGuid = UserInfoDto.Guid;

        new LatestNewsService().CreateOrEdit(dto);

        return new ResponseDto
                {
                    IsValid = true,
                };
    }
}
```
