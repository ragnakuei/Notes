# IRouteHandler

## 透過 Route Handler 進行 Property DI

### Global.asax.cs

於網站啟動時，就建立 DiFactory 並放至 Application["DiContainer"] 中

```csharp
public class Global : HttpApplication
{
    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);
        
        Application["DiContainer"] = new DiFactory();
    }
}
```

### Page

/Order/List.aspx

```csharp
public partial class List : Page
{
    public IOrderService OrderService { get; set; }
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}
```

### 設定 Route

```csharp
public static class RouteConfig
{
    public static void RegisterRoutes(RouteCollection routes)
    {
        var settings = new FriendlyUrlSettings();
        settings.AutoRedirectMode = RedirectMode.Permanent;

        routes.Add("OrderList"
                 , new Route("Order/List"
                 , new DiRouteHandler("~/Order/List.aspx")));
        
        routes.EnableFriendlyUrls(settings);
    }
}
```

### IRouteHandler 呼叫 DI 

透過 Application["DiContainer"] 取出 DiFactory

```csharp
public class DiRouteHandler : IRouteHandler
{
    public string VirtualPath { get; private set; }

    public DiRouteHandler(string virtualPath)
    {
        this.VirtualPath = virtualPath;
    }
    public IHttpHandler GetHttpHandler(RequestContext requestContext)
    {
        var page = BuildManager.CreateInstanceFromVirtualPath(this.VirtualPath, typeof(Page)) as IHttpHandler;
        if (page != null)
        {
            var container = requestContext.HttpContext.Application["DiContainer"] as IDiFactory;
            container?.DiPropetiesForWebForm(page, container);
        }
        return page;
    }     
}
```

### DI 處理

```csharp
public class DiFactory : IDiFactory
{
    private readonly ServiceProvider _serviceProvider;

    public DiFactory()
    {
        var services = new ServiceCollection();
        services.AddSingleton<IDiFactory, DiFactory>();
        services.AddBusinessLogicServices();

        services.AddTransient<IConfiguration>(s => ConfigurationHelper.GetConfiguration());
        
        _serviceProvider = services.BuildServiceProvider();
    }

    public T GetService<T>()
    {
        return _serviceProvider.GetService<T>();
    }
    
    public object GetService(Type propPropertyType)
    {
        return _serviceProvider.GetService(propPropertyType);
    }

    public void DiPropetiesForWebForm(IHttpHandler page, IDiFactory container)
    {
        var properties = GetInjectableProperties(page.GetType());

        foreach (var prop in properties)
        {
            try
            {
                var service = container.GetService(prop.PropertyType);
                if (service != null)
                {
                    // DI Property
                    prop.SetValue(page, service);
                }
            }
            catch(Exception e)
            {
                // DiFactory 沒辦法解析的型別
            }
        }
    }

    private static PropertyInfo[] GetInjectableProperties(Type type)
    {
        var props = type.GetProperties(BindingFlags.Public 
                                                         | BindingFlags.Instance 
                                                         | BindingFlags.DeclaredOnly);
        if (props.Length == 0)
        {
            // 傳入的型別若是由 ASPX 頁面所生成的類別，那就必須取得其父類別（code-behind 類別）的屬性。
            props = type.BaseType.GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
        }
        return props;
    }  
}

```
