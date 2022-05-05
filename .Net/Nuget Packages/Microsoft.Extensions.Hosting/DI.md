# DI

可以直接 DI IServiceProvider !

```cs
public class XXXService : IXXXService
{
    private readonly IServiceProvider _serviceProvider;

    public XXXService(IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }
}
```
