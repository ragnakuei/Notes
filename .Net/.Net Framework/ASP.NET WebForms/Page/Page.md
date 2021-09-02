# [Page](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.page)

[Page Lifecycle](https://docs.microsoft.com/en-us/previous-versions/ms178472(v=vs.140)?redirectedfrom=MSDN)

---

## [AutoEventWireup](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.configuration.pagessection.autoeventwireup)

- [最好停用 AutoEventWireup](https://stackoverflow.com/questions/1494543/what-calls-page-load-and-how-does-it-do-it)

    > Now it is better to disable AutoEventWireup and either create these event handlers yourself in the pages OnInit method or simply override the parent page's OnLoad method.


## 不使用 Code-Behind


```csharp
<%@ Page Title="Home Page" Language="C#"
AutoEventWireup="true" Inherits="WebSample.Index" %>

<script language="c#"
        runat="server">
    public void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Redirect("/Account/Login.aspx");
    }
</script>
```