# Cookie

參考資料

-   [Use cookie authentication without ASP.NET Core Identity](https://docs.microsoft.com/zh-tw/aspnet/core/security/authentication/cookie)

注意事項：
- 登出後，會自動清除 Authtication Cookie !
- Authentication Cookie 
  - 有二個地方可以設定
    1. Startup.Configuration()
        ```csharp
        services.AddAuthentication(CookieSchema.Authentication)
                // .AddCookie(CookieSchema.Authentication);
                .AddCookie(CookieSchema.Authentication,
                            options =>
                            {
                                options.LoginPath          = "/Account/Login";
                                options.LogoutPath         = "/Account/Logout";
                                options.AccessDeniedPath   = "/Account/AccessDenied";
                                options.ReturnUrlParameter = "returnUrl";

                                // 以下可被 AuthenticationProperties 覆蓋掉
                                // options.ExpireTimeSpan     = TimeSpan.FromDays(1);
                                options.ExpireTimeSpan     = TimeSpan.FromSeconds(10);
                                options.SlidingExpiration = true;

                                options.Cookie = new CookieBuilder
                                                {
                                                    // Name         = null,
                                                    // Path         = null,
                                                    // Domain       = null,
                                                    HttpOnly     = true,
                                                    SameSite     = SameSiteMode.Strict,
                                                    SecurePolicy = CookieSecurePolicy.Always,

                                                    // 不可以使用，會產生 Exception，直接用 ExpireTimeSpan 取代
                                                    // Expiration   = TimeSpan.FromSeconds(5),

                                                    // MaxAge       = null,
                                                    IsEssential = false
                                                };
                            });
        ```
    1. 登入的當下，給定 AuthenticationProperties
        ```csharp
        var authProperties = new AuthenticationProperties
                                {
                                    AllowRefresh = true,
                                    ExpiresUtc = DateTimeOffset.UtcNow.AddSeconds (10),
                                    IsPersistent = false,
                                    // IssuedUtc = <DateTimeOffset>,
                                    // RedirectUri = <string>
                                };
     ```
  - 優先序 2 > 1，但為避免混淆，可以只設定 1

- Expire 探討：

  1. Authentication Cookie 與一般的 Cookie 不同，已知的不同點為
     1. Expire 都是標示 Session，但是 Asp.Net Core 會依照登入狀態進行判斷
        可能的好處：
        - 無法從 Client 看出 Expire 的時間
        
        > 如果是多個 Web Server 的架構，則建議用 JWT 比較簡單 !
        
  2. AllowRefresh 設定為 true 之後，會在每次的 request 都重置 ExpiresUtc 所設定的逾時時間 !
     - 或是直接想成 ExpiresUtc 變成 `閒置逾時` !
     - 等於 `SlidingExpiration = true` 的效果