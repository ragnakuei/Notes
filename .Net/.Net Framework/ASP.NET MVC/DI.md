# DI

## Microsoft.Extensions.DependencyInjection

### Web.config

assemblyBinding 中加上以下參考

```xml
<dependentAssembly>
    <assemblyIdentity name="Microsoft.Extensions.DependencyInjection.Abstractions" culture="neutral" publicKeyToken="adb9793829ddae60" />
    <bindingRedirect oldVersion="0.0.0.0-3.1.4.0" newVersion="3.1.4.0" />
</dependentAssembly>
<dependentAssembly>
    <assemblyIdentity name="System.Threading.Tasks.Extensions" culture="neutral" publicKeyToken="cc7b13ffcd2ddd51" />
    <bindingRedirect oldVersion="0.0.0.0-4.2.0.1" newVersion="4.2.0.1" />
</dependentAssembly>
```

### Global.asax.cs

```csharp
DependencyResolver.SetResolver(new DiFactory());
```

### DiFactory

```csharp
public class DiFactory : IDependencyResolver
{
    private readonly ServiceProvider _serviceProvider;

    public DiFactory()
    {
        var services = new ServiceCollection();
        services.AddTransient<HomeController>();
        services.AddTransient<AccountController>();
        services.AddTransient<YoutubeController>();
        services.AddSingleton<DiFactory>();
        services.AddSingleton<IConfigurationService, ConfigurationService>();
        services.AddTransient<AccountService>();

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

    public IEnumerable<object> GetServices(Type serviceType)
    {
        return Enumerable.Empty<object>();
    }
}
```
