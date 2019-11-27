# Route

## 功能

讓 /order/list.aspx 的頁面，可以透過 order/list 來瀏覽

## 語法

Global.asax.cs

```csharp
public class Global : HttpApplication
{
    void Application_Start(object sender, EventArgs e)
    {
        RouteConfig.RegisterRoutes(RouteTable.Routes);  // 加上這行
        BundleConfig.RegisterBundles(BundleTable.Bundles);
    }
}
```

加上以下程式碼

```csharp
public static class RouteConfig
{
    public static void RegisterRoutes(RouteCollection routes)
    {
        var settings = new FriendlyUrlSettings();
        settings.AutoRedirectMode = RedirectMode.Permanent;
        routes.EnableFriendlyUrls(settings);
    }
}
```
