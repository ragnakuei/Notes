# 加上 AntiFogery 的方式

安裝套件：
> Microsoft.AspNet.WebPages

```csharp
public class AntiForgeryToken
{
    private static string CookieName = "AntiForgeryCookie";

    public static string FormTokenHeaderName = "RequestVerificationToken";

    public static string GetToken()
    {
        var cookieToken = string.Empty;
        var formToken   = string.Empty;
        AntiForgery.GetTokens(null, out cookieToken, out formToken);

        HttpContext.Current.Response.Cookies.Add(new HttpCookie(CookieName, cookieToken));

        return formToken;
    }

    public static void ValidateToken()
    {
        var cookieToken = HttpContext.Current.Request.Cookies.Get(CookieName)?.Value;
        var formToken   = HttpContext.Current.Request.Headers.Get(FormTokenHeaderName);

        AntiForgery.Validate(cookieToken, formToken);
    }
}
```