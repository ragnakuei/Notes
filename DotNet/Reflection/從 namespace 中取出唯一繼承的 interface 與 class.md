# 從 namespace 中取出唯一繼承的 interface 與 class

```csharp
void Main()
{
    var serviceTypes = Assembly.GetExecutingAssembly()
                               .GetTypes()
                               .Where(i => i.Name.EndsWith("Service", StringComparison.OrdinalIgnoreCase));

    foreach (var interfaceType in serviceTypes.Where(t => t.IsInterface))
    {
        var implementClassType = serviceTypes.FirstOrDefault(t => t.IsInterface == false
                                                               && interfaceType.IsAssignableFrom(t));

        if (implementClassType != null)
        {
            interfaceType.Dump();
            implementClassType.Dump();
        }
    }
}

public interface IAService
{
    void Test();
}

public class AService : IAService
{
    public void Test()
    {

    }
}
```
