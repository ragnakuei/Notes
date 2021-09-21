# ValidateAntiForgeryToken

## Web API 套用方式

[Prevent Cross-Site Request Forgery (XSRF/CSRF) attacks in ASP.NET Core - JavaScript, AJAX, and SPAs](https://docs.microsoft.com/zh-tw/aspnet/core/security/anti-request-forgery#javascript-ajax-and-spas)

-   產生 Token
-   在 Request Header 加上 `RequestVerificationToken` ，並把 Token 放進去
-   就可以在 web api action 上面加上 `ValidateAntiForgeryToken` 的 Attribute

### 範例

產生 Token 的方式

```csharp
@inject Microsoft.AspNetCore.Antiforgery.IAntiforgery Xsrf
@functions{
    public string GetAntiXsrfRequestToken()
    {
        return Xsrf.GetAndStoreTokens(Context).RequestToken;
    }
}

<script>
    window.Antiforgery = {};

    Antiforgery.RequestVerificationToken = '@(GetAntiXsrfRequestToken())';
</script>
```

jQUery 套用 Token 的方式

```csharp
$.ajax({
    beforeSend: function(request) {
    request.setRequestHeader("RequestVerificationToken", Antiforgery.RequestVerificationToken);
    },
    url: Login.Url,
    data: Login.RequestBody,
    type: 'post',
    success: jQueryParameter.Response,
    error: jQueryParameter.RequestError,

})
```

就可以在 web api action 上面加上 `ValidateAntiForgeryToken` 的 Attribute
