# Microsoft.Extensions.DependencyInjection

此套件為 DotNet Core 預設的 DI 套件，目前測試可用於 DotNet Framework 上

安裝套件

> Microsoft.Extensions.DependencyInjection

讓 Web API 2 改用此套件做為 DI 元件

WebApiConfig.cs

```csharp
public static void Register(HttpConfiguration config)
{
    // Web API 設定和服務

    // Web API 路由
    config.MapHttpAttributeRoutes();

    config.Routes.MapHttpRoute(
                                name : "DefaultApi",
                                routeTemplate : "api/{controller}/{id}",
                                defaults : new { id = RouteParameter.Optional }
                                );

    // 加上以下程式碼
    var services = new ServiceCollection();
    services.AddControllersAsServices();
    services.AddBusinessLogicServices();

    var provider = services.BuildServiceProvider();
    config.DependencyResolver = new MyDependencyResolver(provider);  
}

public static class ServiceProviderExtensions
{
    public static void AddControllersAsServices(this IServiceCollection services)
    {
        var controllerTypes = Assembly.GetExecutingAssembly()
                                        .GetTypes()
                                        .Where(t => !t.IsAbstract && !t.IsGenericTypeDefinition)
                                        .Where(t => typeof(ApiController).IsAssignableFrom(t)
                                                || t.Name.EndsWith("Controller", StringComparison.CurrentCultureIgnoreCase));

        foreach (var type in controllerTypes)
        {
            services.AddTransient(type);
        }
    }

    public static void AddBusinessLogicServices(this IServiceCollection services)
    {
        var serviceTypes = Assembly.Load("BusinessLogic")
                                    .GetTypes()
                                    .Where(i => i.Name.EndsWith("Service", StringComparison.OrdinalIgnoreCase))
                                    .ToArray();

        foreach (var interfaceType in serviceTypes.Where(t => t.IsInterface))
        {
            var implementClassType = serviceTypes.FirstOrDefault(t => t.IsInterface == false
                                                                    && interfaceType.IsAssignableFrom(t)
                                                                    && !t.IsInterface && !t.IsAbstract);
            if (interfaceType != null
                && implementClassType != null)
            {
                typeof(ServiceCollectionServiceExtensions)
                    .GetMethods()
                    .FirstOrDefault(m => m.Name.Equals("AddTransient", StringComparison.CurrentCultureIgnoreCase)
                                        && m.IsGenericMethod
                                        && m.GetParameters().Length == 1)
                    ?.MakeGenericMethod(interfaceType, implementClassType)
                    .Invoke(null, new object[] { services });
            }
        }
    }
}
```
