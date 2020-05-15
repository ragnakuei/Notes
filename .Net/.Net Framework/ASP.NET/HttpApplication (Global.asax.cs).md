# HttpApplication (Global.asax.cs)

在 Asp.Net 架構下，都會是以 Global.asax.cs 來繼承 HttpApplication

## HttpApplication

[HttpApplication 類別 (System.Web)](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication)

[Asp.Net](http://asp.Net) 一開始進入點是

```csharp
protected void Application_Start()
{

}
```

應用程式事件會依照下列順序引發：

1. [BeginRequest](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.beginrequest?view=netframework-4.8)
2. [AuthenticateRequest](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.authenticaterequest?view=netframework-4.8)
3. [PostAuthenticateRequest](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postauthenticaterequest?view=netframework-4.8)
4. [AuthorizeRequest](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.authorizerequest?view=netframework-4.8)
5. [PostAuthorizeRequest](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postauthorizerequest?view=netframework-4.8)
6. [ResolveRequestCache](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.resolverequestcache?view=netframework-4.8)
7. [PostResolveRequestCache](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postresolverequestcache?view=netframework-4.8)
8. [PostMapRequestHandler](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postmaprequesthandler?view=netframework-4.8)
9. [AcquireRequestState](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.acquirerequeststate?view=netframework-4.8)
10. [PostAcquireRequestState](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postacquirerequeststate?view=netframework-4.8)
11. [PreRequestHandlerExecute](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.prerequesthandlerexecute?view=netframework-4.8)
12. [PostRequestHandlerExecute](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postrequesthandlerexecute?view=netframework-4.8)
13. [ReleaseRequestState](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.releaserequeststate?view=netframework-4.8)
14. [PostReleaseRequestState](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postreleaserequeststate?view=netframework-4.8)
15. [UpdateRequestCache](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.updaterequestcache?view=netframework-4.8)
16. [PostUpdateRequestCache](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postupdaterequestcache?view=netframework-4.8)
17. [LogRequest](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.logrequest?view=netframework-4.8)
18. [PostLogRequest](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.postlogrequest?view=netframework-4.8)
19. [EndRequest](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.httpapplication.endrequest?view=netframework-4.8)

上述的事件名稱，只要取代以下面的 method 內的 XXX，就可以拿來用了

```csharp
private void Application_XXX(object sender, EventArgs e)
{
}
```

## AuthenticateRequest 範例

程式碼的內容沒有太特別的意思，只是重新抓出 Identity 的東西，再重新給定

```sql
protected void Application_AuthenticateRequest(object sender, EventArgs e)
{
    if ((HttpContext.Current.User?.Identity.IsAuthenticated ?? false)
     && HttpContext.Current.User.Identity is FormsIdentity identity)
    {
        var ticket   = identity.Ticket;
        var userData = JsonConvert.DeserializeObject<UserDto>(ticket.UserData);
        var roles    = userData.Roles;
        HttpContext.Current.User = new GenericPrincipal(identity, roles);
    }
}
```