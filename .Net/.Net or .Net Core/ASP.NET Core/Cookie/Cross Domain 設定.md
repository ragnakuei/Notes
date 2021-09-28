# Cross Domain 設定

參考資料
- https://stackoverflow.com/questions/3342140/cross-domain-cookies

### 設定方式

#### Asp.Net Core WebApi

基本上要先套用好 CORS，讓 Request 可以打進後端

讓 angular 可以打進後端，所設定的 CORS

Startup.Configure()

```csharp
app.UseCors(options =>
            {
                options.WithOrigins("http://localhost:4200")
                        .WithMethods("Post")

                        // 以下二個不加，request 會判斷 CORS 不會過，但是 Cross Domain Cookie 是可以設定成功的 !!
                        .AllowAnyHeader()
                        .AllowCredentials();
            });
```

在 Controller Action 內就可以直接這樣建立 Cookie

    - Domain 一定要設對，不需要加 protocol (http/https) 及 port
    - SameSite 一定要設定為 None
      - 因為設定為 SameSite.None 後，連帶 Secure 一定要設定為 true，才會正常 !
    - HttpOnly 就可以視情況決定

```csharp
var tokenSet = _antiforgery.GetAndStoreTokens(HttpContext);
HttpContext.Response.Cookies.Append(".AspNetCore.Antiforgery-Token",
                                    tokenSet.RequestToken,
                                    new CookieOptions
                                    {
                                        HttpOnly = false,
                                        Domain   = "localhost",
                                        SameSite = SameSiteMode.None,
                                        Secure   = true,
                                    });
```

#### JavaScript fetch

一定要加上 `credentials: "include"`

```js
ngOnInit(): void {
    fetch('https://localhost:5001/api/AntiforgeryToken/Get', {
        method: "Post",

        // 要加上這個，才可以套用 Cookie 的 Cross Domain
        credentials: "include",
    }).then((response: Response) => {
        console.log(response);
    })
}
```
