# 支援 Antifogery 的套件

引用：
- System.Web

套件名：
- Microsoft.AspNet.Webpages

驗証 Antifogery Token

```csharp
public class AntiForgeryTokenHelper
{
    public static string GetToken()
    {
        AntiForgery.GetTokens(null, out var cookieToken, out var formToken);
        return cookieToken + SystemConst.AntiForgeryTokenDelimiter + formToken;
    }

    public static void ValidateToken(string token)
    {
        var cookieToken = String.Empty;
        var formToken   = String.Empty;
        if (token.IsNullOrWhiteSpace() == false)
        {
            string[] tokens = token.Split(SystemConst.AntiForgeryTokenDelimiter);
            if (tokens.Length == 2)
            {
                cookieToken = tokens[0].Trim();
                formToken   = tokens[1].Trim();
            }
        }

        AntiForgery.Validate(cookieToken, formToken);
    }
}

```