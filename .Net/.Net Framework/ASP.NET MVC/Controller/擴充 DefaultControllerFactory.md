# 擴充 DefaultControllerFactory

DefaultControllerFactory 是 MVC 內建的，如果有程式需要在建立 Controller 後，要立即處理的，可以藉由這個方式來解決

## 擴充 DefaultControllerFactory

```csharp
public class CustomControllerFactory : DefaultControllerFactory
{
    public CustomControllerFactory() 
        : base()
    {
    }
    
    public CustomControllerFactory(IControllerActivator controllerActivator)
        : base(controllerActivator)
    {
    }
}
```

## Global.asax.cs

```csharp
public class MvcApplication : System.Web.HttpApplication
{
    protected void Application_Start()
    {
        AreaRegistration.RegisterAllAreas();
        RouteConfig.RegisterRoutes(RouteTable.Routes);

        // 加上這段
        ControllerBuilder.Current.SetControllerFactory(typeof (CustomControllerFactory));
    }
}
```


