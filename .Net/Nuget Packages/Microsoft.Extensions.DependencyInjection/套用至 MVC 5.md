# 套用至 MVC 5

[資料來源](https://www.facebook.com/will.fans/videos/271242413931518)

```csharp
public class MvcApplication : System.Web.HttpApplication
{
    protected void Application_Start()
    {
        AreaRegistration.RegisterAllAreas();
        FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);

        var services = new ServiceCollection();
        ConfigureService(services);

        var resolver = new DotNetCoreDIDependencyResolver(services.BuildServiceProvider());
        DependencyResolver.SetResolver(resolver);
    }

    private void ConfigureService(ServiceCollection services)
    {
        var controllers = typeof(MvcApplication).Assembly
            .GetExportedTypes()
            .Where(t => t.IsAbstract == false)
            .Where(t => typeof(IController).IsAssignableFrom(t))
            .Where(t => t.Name.EndsWith("Controller"));
        foreach (var controller in controllers)
        {
            services.AddTransient(controller);
        }

        services.AddTransient<IMessageService, MessageService>();

        //services.AddHttpClient();
    }
}

internal class DotNetCoreDIDependencyResolver : IDependencyResolver
{
    private readonly IServiceProvider buildServiceProvider;

    public DotNetCoreDIDependencyResolver(IServiceProvider buildServiceProvider)
    {
        this.buildServiceProvider = buildServiceProvider;
    }

    public object GetService(Type serviceType)
    {
        return buildServiceProvider.GetService(serviceType);
    }

    public IEnumerable<object> GetServices(Type serviceType)
    {
        return buildServiceProvider.GetServices(serviceType);
    }
}
```
