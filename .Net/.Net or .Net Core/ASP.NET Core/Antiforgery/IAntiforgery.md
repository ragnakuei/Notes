# IAntiforgery

### ValidateRequestAsync(HttpContext)

傳入 HttpContext 進行 Antiforgery 驗証 !

驗証來源：
- Cookie
  - Http Only
  - Secure
  - Name
    - .AspNetCore.Antiforgery.亂數
- Token
  - 二個來源擇一
    - Header
      - 預設 Header Name：**RequestVerificationToken**
    - RequestBody
      - content type 為 form-data 時，會讀取 property name 為 **__RequestVerificationToken** 的值

### SetCookieTokenAndHeader()

- 產生 .AspNetCore.Antiforgery.亂數 的 Response Header Set-Cookie

### GetAndStoreTokens()

- 已包含了 SetCookieTokenAndHeader() 的動作
- 產生 Token 並儲存
- 可能多次取出相同的 Token，Expire 條件不清楚

手動給定 Antiforgery Token 加到 Cookie 中

```csharp
// GetAndStoreTokens 已包含了 SetCookieTokenAndHeader() 的動作
var tokenSet = _antiforgery.GetAndStoreTokens(context.HttpContext);

// 產生 Antiforgery Token 至 Response Header Set-Cookie
context.HttpContext.Response.Cookies.Append(".AspNetCore.Antiforgery.Token",
                                            tokenSet.RequestToken,
                                            new CookieOptions()
                                            {
                                                HttpOnly = false,
                                                Secure   = true,
                                                SameSite = SameSiteMode.Strict,
                                                Domain   = "localhost"
                                            });
```

### GetAndStoreTokens()

- 已包含了 SetCookieTokenAndHeader() 的動作
- 產生 Token 並儲存
- 每次都會取出新的 Token，但舊的 Token 不會 Expire


### ValidateRequestAsync()

- 可能產生 AntiforgeryValidationException
  - 可以在 Middleware 被 catch

#### 驗証 IAntiforgery 可以拋出 AntiforgeryValidationException 的做法

  - 通常搭配 Web Api 使用

  ```cs
  public class CsrfTokenValidateService : IAsyncActionFilter
  {
      private readonly IAntiforgery _antiforgery;

      public CsrfTokenValidateService(IAntiforgery antiforgery)
      {
          _antiforgery = antiforgery;
      }

      public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
      {
          await _antiforgery.ValidateRequestAsync(context.HttpContext);
          await next();
      }
  }
  ```