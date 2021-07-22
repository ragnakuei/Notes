# FormAuthentication.md

參考資料：
- [簡介 ASP.NET 表單驗證 (FormsAuthentication) 的運作方式](https://blog.miniasp.com/post/2008/02/20/Explain-Forms-Authentication-in-ASPNET-20)
- [ASP.NET 自訂角色的方式（不用實做 Role Provider）](https://blog.miniasp.com/post/2008/06/11/How-to-define-Roles-but-not-implementing-Role-Provider-in-ASPNET)

## 範例

- 登入

    ```csharp
    private void LoginAsync(UserInfoDto userInfoDto)
    {
        Session.Clear();

        var ticket = new FormsAuthenticationTicket(version: 1,
                                                    name: userInfoDto.Name,
                                                    issueDate: DateTime.Now,
                                                    expiration: DateTime.Now.AddMinutes(30),
                                                    isPersistent: false,
                                                    userData: userInfoDto.Role,
                                                    cookiePath: FormsAuthentication.FormsCookiePath);

        var encTicket = FormsAuthentication.Encrypt(ticket);

        Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));
    }
    ```

- 登入後將資料放至 Identity 內

    ```csharp
    public class MvcApplication : System.Web.HttpApplication
    {
        private void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {
                // 先取得該使用者的 FormsIdentity
                FormsIdentity id = (FormsIdentity)User.Identity;

                // 再取出使用者的 FormsAuthenticationTicket
                FormsAuthenticationTicket ticket = id.Ticket;

                // 將儲存在 FormsAuthenticationTicket 中的角色定義取出，並轉成字串陣列
                string[] roles = ticket.UserData.Split(new char[] { ',' });

                // 指派角色到目前這個 HttpContext 的 User 物件去
                Context.User = new GenericPrincipal(Context.User.Identity, roles);
            }
        }
    }
    ```

- 登出

    ```csharp
    [HttpGet]
    [Authorize]
    public ActionResult Logout()
    {
        FormsAuthentication.SignOut();

        Session.Clear();

        return RedirectToAction(nameof(AccountController.Login),
                                nameof(AccountController).Replace("Controller", string.Empty));
    }
    ```
