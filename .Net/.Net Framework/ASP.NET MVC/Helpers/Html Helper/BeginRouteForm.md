# BeginRouteForm

Default 為 RouteConfig.cs 內的 routename

Route 的原理與 RouteLink 相同

```csharp
@using (Html.BeginRouteForm("Default", new { action = "Index" }))
{
    
}
```