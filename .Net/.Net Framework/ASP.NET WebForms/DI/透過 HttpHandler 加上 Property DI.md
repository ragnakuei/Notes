# 透過 HttpHandler 加上 Property DI

跟 RouteHandler 混用時，不好理 非 .aspx 的部份，目前還沒找到好處理的方式 !!

## 範例

### Handler

/api/Order/List.ashx

因為在 PageHandlerFactory 中，要透過 PageHandlerFactory.GetHandler() 中取出 IHttpHandler 的方式已限定為 Page (以 F12 往內追二次就可以看到了) 所以將 ashx 原本要實作 IHttpHandler 改為繼承 Page
然後再 override ProcessRequest(HttpContext context) 及 new bool IsReusable 就可以了 !!

```csharp
using System;
using System.Web;
using System.Web.UI;
using BusinessLogic.Order;
using Newtonsoft.Json;

namespace WebForm.API.Order
{
    /// <summary>
    /// Summary description for List
    /// </summary>
    public class List : Page
    {
        public IOrderService OrderService { get; set; }

        public override void ProcessRequest(HttpContext context)
        {
            if (string.Equals(context.Request.HttpMethod, "GET", StringComparison.CurrentCultureIgnoreCase) == false)
            {
                context.Response.StatusCode = 404;
                return;
            }

            Int32.TryParse(context.Request.Form["pageIndex"], out int pageIndex);
            Int32.TryParse(context.Request.Form["pageSize"], out int pageSize);

            if (pageSize == 0)
            {
                pageSize = 10;
            }
            
            var orderList = OrderService.GetOrderList(pageIndex, pageSize);
            var json = JsonConvert.SerializeObject(orderList);

            context.Response.ContentType = "application/json";
            context.Response.Charset = "utf-8";
            context.Response.Write(json);
        }

        public new bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
```

### Global.asax.cs

於網站啟動時，就建立 DiFactory 並放至 Application[“DiContainer”] 中

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

### PageHandlerFactory 實作

透過 Application[“DiContainer”] 取出 DiFactory

```csharp
public class DiPageHandlerFactory : PageHandlerFactory
{
    public override IHttpHandler GetHandler(HttpContext context,
                                            string requestType,
                                            string virtualPath,
                                            string path)
    {
        Page page = base.GetHandler(context, requestType, virtualPath, path) as Page;
        if (page != null)
        {
            var container = context?.Application["DiContainer"] as IDiFactory;
            container?.DiPropetiesForWebForm(page, container);
        }

        return page;
    }
}
```

### 設定 Web.config 指向 HttpHandler

```csharp
<system.webServer>
  <handlers>
    <add name="DiPageHandlerFactory" path="*.aspx" verb="*" type="WebForm.HttpHandlers.DiPageHandlerFactory" />
  </handlers>
</system.webServer>
```

### DI 處理

```csharp
public class DiFactory : IDiFactory
{
    private readonly ServiceProvider _serviceProvider;

    public DiFactory()
    {
        var services = new ServiceCollection();
        services.AddSingleton<IDiFactory, DiFactory>(s => this);
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