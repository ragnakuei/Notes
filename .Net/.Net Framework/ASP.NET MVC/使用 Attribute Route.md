# 使用 Attribute Route

安裝套件 `AttributeRouting`


```csharp
public class RouteConfig
{
    public static void RegisterRoutes(RouteCollection routes)
    {
        routes.IgnoreRoute(“{resource}.axd/{*pathInfo}”);
 
        // 要加上這一行
        routes.MapMvcAttributeRoutes();
    }
}
```