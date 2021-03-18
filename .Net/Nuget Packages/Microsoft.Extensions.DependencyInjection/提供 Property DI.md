# 提供 Property DI

---

## Asp.Net MVC 版

在某個 Class 內以下面的方式宣告 Property

```csharp
[DiProperty]
public CustomAuthorizeDto CustomAuthorizeDto { get; set; }
```

DiPropertyAttribute 就只需要宣告，不需實作


```csharp
public class DiPropertyAttribute : Attribute { }
```

Resolver 的部份

```csharp
public class DependencyInjectionResolver : IDependencyResolver
{
    #region implement

    public object GetService(Type serviceType)
    {
        var result = _provider.GetService(serviceType);
        DiPropery(result);
        return result;
    }

    public IEnumerable<object> GetServices(Type serviceType)
    {
        return _provider.GetServices(serviceType);
    }

    #endregion

    private static readonly ServiceProvider _provider;

    static DependencyInjectionResolver()
    {
        var service = new ServiceCollection();

        service.AddDbContext<AccountDbContext>(options => options
                                                         .UseSqlServer(ConfigurationManager.ConnectionStrings["AuthorizePractice"].ConnectionString)
                                                         .UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking),
                                               ServiceLifetime.Scoped,
                                               ServiceLifetime.Scoped);
        service.AddTransient<AuthController>();
        service.AddTransient<HomeController>();
        service.AddTransient<ErrorController>();
        service.AddTransient<MemberController>();

        service.AddScoped<IUserRepository, UserRepository>();
        service.AddScoped<IRouteRoleRepository, RouteRoleRepository>();
        _provider = service.BuildServiceProvider();
    }

    public static T GetService<T>()
    {
        var result = _provider.GetService<T>();
        DiPropery(result);
        return result;
    }

    private static object GetServiceByType(Type serviceType)
    {
        var result = _provider.GetService(serviceType);
        DiPropery(result);
        return result;
    }

    private static void DiPropery<T>(T instance)
    {
        var properties = GetInjectableProperties(instance?.GetType());

        foreach (var prop in properties)
        {
            try
            {
                var propertyInstance = GetServiceByType(prop.PropertyType);
                if (propertyInstance != null)
                {
                    // DI Property
                    prop.SetValue(instance, propertyInstance);
                }
            }
            catch (Exception e)
            {
                // DiFactory 沒辦法解析的型別
            }
        }
    }

    /// <summary>
    /// 取得有 CustomAttribute DiPropertyAttribute 的 PropertyInfos
    /// </summary>
    private static IEnumerable<PropertyInfo> GetInjectableProperties(Type type)
    {
        return type?.GetProperties()
                    .Where(p => ContainsDiPropertyAttribute(p))
            ?? Enumerable.Empty<PropertyInfo>() ;
    }

    /// <summary>
    /// 判斷 PropertyInfo 是否有 CustomAttribute DiPropertyAttribute
    /// </summary>
    private static bool ContainsDiPropertyAttribute(PropertyInfo p)
    {
        return p.CustomAttributes.Any(a => a.AttributeType == typeof(DiPropertyAttribute));
    }
}
```

---

## Asp.Net WebForm 版

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