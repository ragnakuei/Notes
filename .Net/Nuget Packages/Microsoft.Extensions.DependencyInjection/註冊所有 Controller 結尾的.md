# 註冊所有 Controller 結尾的

```csharp
public static void AddControllersAsServices(this IServiceCollection services)
{
    var controllerTypes = Assembly.GetExecutingAssembly()
                                  .GetTypes()
                                  .Where(t => !t.IsAbstract && !t.IsGenericTypeDefinition)
                                  .Where(t => typeof(ApiController).IsAssignableFrom(t)
                                           || t.Name.EndsWith("Controller", StringComparison.OrdinalIgnoreCase));

    foreach (var type in controllerTypes)
    {
        services.AddTransient(type);
    }
}
```


