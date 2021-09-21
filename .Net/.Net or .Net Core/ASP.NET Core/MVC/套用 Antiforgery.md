# 套用 Antiforgery

-   把以下 `Antiforgery.RequestVerificationToken` 放到 request header 中就可以了
-   搭配 [CustomRequest](./../../../../FrontEnd/JavaScript%20Library/jQuery/CustomRequest.md)

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
