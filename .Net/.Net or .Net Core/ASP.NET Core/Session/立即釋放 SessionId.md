# 立即釋放 SessionId

```csharp
public IActionResult ExpireSessionCookie()
{
    Session.Clear();
    Response.Cookies.Append("TestSession",
                            string.Empty,
                            new CookieOptions
                            {
                                // Domain      = null,
                                // Path        = null,
                                Expires  = DateTimeOffset.Now.AddDays(-1),
                                Secure   = true,
                                SameSite = SameSiteMode.Strict,
                                HttpOnly = true,
                                // MaxAge      = null,
                                // IsEssential = false
                            });

    // 最好用 Redirect 的方式來完整清掉 Session Id
    return RedirectToAction("Index");
}
```