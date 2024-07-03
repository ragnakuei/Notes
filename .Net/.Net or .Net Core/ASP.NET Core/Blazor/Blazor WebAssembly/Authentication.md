# Authentication

-   [Part-1 Blazor WebAssembly Cookie Authentication[.NET 6]](https://www.learmoreseekmore.com/2022/04/blazorwasm-cookie-series-part-1-blazor-webassembly-cookie-authentication.html)
-   [Secure an ASP.NET Core Blazor WebAssembly standalone app with the Authentication library](https://docs.microsoft.com/en-us/aspnet/core/blazor/security/webassembly/standalone-with-authentication-library)

Packages

-   Microsoft.AspNetCore.Components.WebAssembly.Authentication

重點：

-   判斷是否已登入的邏輯
    -   AuthenticationState.ClaimsPrincipal.ClaimsIdentity 是否有給定 AuthenticationType !
        -   空字串會被視為未登入
    -   Claims 的數量無關登入的狀態 !
-   以下的 razor component 都要記得 @using Microsoft.AspNetCore.Components.Authorization，最好的方式是直接在 \_Imports.razor 中加入
    -   CascadingAuthenticationState
    -   AuthorizeRouteView
        -   裡面只能用 NotAuthorized / Authorizing，沒有 Authorized !
    -   AuthorizeView
    -   Authorized
    -   NotAuthorized
-   還不知道何時會需要 AuthorizeRouteView.NotAuthorized 的內容 !

## 範例 01

-   TestAuthStateProvider.cs

    ```cs
    public class TestAuthStateProvider : AuthenticationStateProvider
    {
        public override Task<AuthenticationState> GetAuthenticationStateAsync()
        {
            var claims = new List<Claim>()
                        {
                            new Claim(ClaimTypes.Name, "Nick Fury"),
                            new Claim(ClaimTypes.Role, "admin")
                        };

            var authenticationType = string.Empty;   // 未登入
            // var authenticationType = "testAuth";  // 已登入

            var claimsIdentity     = new ClaimsIdentity(claims, authenticationType);
            var claimsPrincipal    = new ClaimsPrincipal(claimsIdentity);
            return Task.FromResult(new AuthenticationState(claimsPrincipal));
        }
    }
    ```

-   program.cs

    ```cs
    builder.Services.AddAuthorizationCore();
    builder.Services.AddScoped<AuthenticationStateProvider, TestAuthStateProvider>();
    ```

-   App.razor

    - 最外層要用 CascadingAuthenticationState 包起來 !

    ```cs
    @using Microsoft.AspNetCore.Components.Authorization

    <CascadingAuthenticationState>
        <Router AppAssembly="@typeof(App).Assembly">
            <Found Context="routeData">

                @* 重點 *@
                <AuthorizeRouteView RouteData="@routeData" DefaultLayout="@typeof(MainLayout)">
                    <Authorizing>
                        <h3> Authorizing ... </h3>
                    </Authorizing>
                    <NotAuthorized>
                        <h3> NotAuthorized </h3>
                    </NotAuthorized>
                </AuthorizeRouteView>

            </Found>
            <NotFound>
                <PageTitle>Not found</PageTitle>
                <LayoutView Layout="@typeof(MainLayout)">
                    <p role="alert">Sorry, there's nothing at this address.</p>
                </LayoutView>
            </NotFound>
        </Router>
    </CascadingAuthenticationState>

    ```

-   Index.razor

    ```cs
    @page "/"
    @using Microsoft.AspNetCore.Components.Authorization

    <PageTitle>Index</PageTitle>

    <h1>Hello, world!</h1>

    Welcome to your new app.

    <SurveyPrompt Title="How is Blazor working for you?" />

    <div class="row">
        <div class="col-8">

            @* 限制 Role 為 admin *@
            @* <AuthorizeView Roles="admin"> *@
            <AuthorizeView>
                <Authorized>
                    <h3>Welcome, @context.User.Identity.Name</h3>
                </Authorized>
                <NotAuthorized>

                    @* 當該頁面有給定 Authorize Attribute 且 未登入 或 不符合 Roles 條件時，就會顯示這個區塊 *@
                    <h3> NotAuthorized ! 未授權進入該頁面 ! </h3>

                </NotAuthorized>
            </AuthorizeView>

        </div>
    </div>

    ```

-   整個頁面需要加上 Authorized 的範例

    ```cs
    @using Microsoft.AspNetCore.Authorization

    @* @attribute [Authorize] *@
    @attribute [Authorize(Roles = "user")]
    ```

### 變化

-   可自由搭配

    -   例：針對不同的 role 顯示不同的 content !

-   index.razor

    ```cs
    <div class="row">
        <div class="col-8">

            <AuthorizeView Roles="admin">
                @* <AuthorizeView> *@
                <Authorized>
                    <h3>Welcome, @context.User.Identity.Name</h3>
                </Authorized>
                <NotAuthorized>
                    <h3> NotAuthorized </h3>
                </NotAuthorized>
            </AuthorizeView>

            <AuthorizeView Roles="user">
                <NotAuthorized>
                    <h3>不是 User，無法瀏覽</h3>
                </NotAuthorized>
            </AuthorizeView>

        </div>
    </div>
    ```
