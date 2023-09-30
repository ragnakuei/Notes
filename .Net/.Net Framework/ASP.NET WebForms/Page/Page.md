# [Page](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.page)

[Page Lifecycle](<https://docs.microsoft.com/en-us/previous-versions/ms178472(v=vs.140)?redirectedfrom=MSDN>)

---

## [AutoEventWireup](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.configuration.pagessection.autoeventwireup)

-   [最好停用 AutoEventWireup](https://stackoverflow.com/questions/1494543/what-calls-page-load-and-how-does-it-do-it)

    > Now it is better to disable AutoEventWireup and either create these event handlers yourself in the pages OnInit method or simply override the parent page's OnLoad method.

### 使用 AutoEventWireup

自動綁定事件，不需要手動綁定，事件順序可參考[這裡](<https://learn.microsoft.com/en-us/previous-versions/aspnet/ms178472(v=vs.100)#life-cycle-events>)

```csharp

protected void Page_PreInit(object sender, EventArgs e)
{
    Console.WriteLine("BasePage PreInit");
}

protected void Page_Init(object sender, EventArgs e)
{
    Console.WriteLine("BasePage Init");
}

protected void Page_PreLoad(object sender, EventArgs e)
{
    Console.WriteLine("BasePage PreLoad");
}

protected void Page_Load(object sender, EventArgs e)
{
    Console.WriteLine("BasePage PageLoad");
}

protected void Page_PreRender(object sender, EventArgs e)
{
    Console.WriteLine("BasePage PreRender");
}

protected void Page_Unload(object sender, EventArgs e)
{
    Console.WriteLine("BasePage Unload");
}

protected void Page_Disposed(object sender, EventArgs e)
{
    Console.WriteLine("BasePage Disposed");
}
```

### 不使用 Code-Behind

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

### 不使用 AutoWireup，手動綁定事件

```csharp
public class Default : Page
{
    protected Default()
    {
        this.Load += new EventHandler(this.Page_Load);
    }

    private void Page_Load(object sender, EventArgs e)
    {
        Console.WriteLine("BasePage PageLoad");
    }
}
```
