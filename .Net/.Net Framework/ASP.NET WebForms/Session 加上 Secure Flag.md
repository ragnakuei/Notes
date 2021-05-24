# Session 加上 Secure Flag

- `ASP.NET_SessionId` 要改成該 Site 預設的 Session 名𢜻
  - Webform 與 Webform WebSite 可能不同

```csharp
protected void Session_Start(Object sender, EventArgs e)
{
    if (Request.IsSecureConnection)
    {
        Response.Cookies["ASP.NET_SessionId"].Secure = true;
    }
}
```