# Ajax CSRF Token.md

參考資料：[ASP.NET MVC 防範 CSRF 攻擊 - 在 AJAX 裡使用 AntiForgeryToken 的處理](https://kevintsengtw.blogspot.com/2013/09/aspnet-mvc-csrf-ajax-antiforgerytoken.html)


## 步驟

1. 建立 AjaxValidateAntiForgeryTokenAttribute

    ```csharp
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = false, Inherited = true)]
    public class AjaxValidateAntiForgeryTokenAttribute : FilterAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            try
            {
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    ValidateRequestHeader(filterContext.HttpContext.Request);
                }
                else
                {
                    filterContext.HttpContext.Response.StatusCode = 404;
                    filterContext.Result                          = new HttpNotFoundResult();
                }
            }
            catch (HttpAntiForgeryException e)
            {
                throw new HttpAntiForgeryException("Anti forgery token cookie not found");
            }
        }

        private void ValidateRequestHeader(HttpRequestBase request)
        {
            string cookieToken = String.Empty;
            string formToken   = String.Empty;
            string tokenValue  = request.Headers["RequestVerificationToken"];
            if (!String.IsNullOrEmpty(tokenValue))
            {
                string[] tokens = tokenValue.Split(':');
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

1. 在指定的 api 套用 AjaxValidateAntiForgeryTokenAttribute

    ```csharp
    [HttpPost]
    [Route("api/PostTest")]
    [AjaxValidateAntiForgeryToken]
    public ActionResult PostTest(TestDto dto)
    {

        return ResponseDto();
    }
    ```

1. 套用至 View 統一的 Ajax Helper

    ```html
    @functions{
        public string GetAntiXsrfRequestToken()
        {
            string cookieToken;
            string formToken;
            AntiForgery.GetTokens(null, out cookieToken, out formToken);
            return cookieToken + ":" + formToken;
        }
    }

    <script>

    fetch(url, {
            body: JSON.stringify(requestBody),
            headers: {
                'X-Requested-With' : 'XMLHttpRequest',   @* 讓後端判定 IsAjaxRequest 為 true *@
                'content-type': 'application/json',
                'RequestVerificationToken': '@(GetAntiXsrfRequestToken())',
            },
            method: 'POST',
        });

    </script>
    ```
