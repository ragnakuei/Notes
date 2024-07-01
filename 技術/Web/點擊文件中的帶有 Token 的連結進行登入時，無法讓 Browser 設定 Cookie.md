# 點擊文件中的帶有 Token 的連結進行登入時，無法讓 Browser 設定 Cookie

如果 Cookie 的 SameSite 設定為 Strict 就無法套用
設定為 Lax 就可以套用，但會有 AppScan 中風險

原因是從文件來開啟網站直接設定 Cookie 時，會是 Cross-Site 行為 !
所以受到 SameSite 約束 !

---

相關判斷

> Request Header Sec-Fetch-Site 的值為 cross-site 時，該次 Request 就無法套用 Set-Cookie !

---

資安風險

要求：Cookie SameSite 要設定為 Strict 為 AppScan 中風險要求 !

解法：

> 讓 cross-site 的 request 先進入到 html，該 html 直接 reload，就會變成符合 SameSite Strict 的要求，進而可以讓 Browser 完成套用 Cookie !

步驟：

1. 調整 MVC Action 的語法，可參考

    ```cs
    /// <summary>
    /// 以 Token 登入
    /// </summary>
    [HttpGet, Route("[Controller]/[Action]/{token}")]
    public IActionResult LoginToken([FromRoute]string token)
    {
        // 已登入，不處理 token 的登入流程
        if (_currentUserService.UserInfo != null)
        {
            return Redirect(Url.Action("Index", "Home"));
        }

        // 取得 request 的 Sec-Fetch-Site
        var secFetchSite = HttpContext.Request.Headers["Sec-Fetch-Site"].ToString();
        if (secFetchSite?.ToLower() == "cross-site")
        {
            // 為 cross-site，直接以頁面顯示，該頁面只做 window.location.reload()
            // 就可以閃過 Cookie SameSite 的限制，後續設定 Cookie 時，就可以正常設定
            return View();
        }

        var userInfo = _voteService.GetLoginInfoFromToken(token);
        if (userInfo == null)
        {
            _logger.LogWarning($"LoginToken: {token} 登入失敗");
            return Redirect(Url.Action("Logout", "Account"));
        }

        HttpContext.Session.SetString(SystemConst.UserInfo, userInfo.ToJson());

        _logger.LogInformation($"LoginToken: {token} 登入成功");
        return Redirect(Url.Action("Index", "Home"));
    }
    ```

1. 在該頁面加上一個 html 頁面

    ```cs
    @using itrivote.Repositories
    @inject CspRepository cspRepository
    <script type="module" nonce="@cspRepository.GetNonce()">
        window.location.reload();
    </script>
    ```
