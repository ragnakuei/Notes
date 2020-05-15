# CORS

安裝套件

> Microsoft.AspNet.WebApi.Cors

全域設定方式

```csharp
public static void Register(HttpConfiguration config)
{
    // Web API 設定和服務

    var cors = new EnableCorsAttribute("http://localhost:4200", "*", "*");
    config.EnableCors(cors);

    // Web API 路由
    config.MapHttpAttributeRoutes();

    config.Routes.MapHttpRoute(
                                name : "DefaultApi",
                                routeTemplate : "api/{controller}/{id}",
                                defaults : new { id = RouteParameter.Optional }
                                );
}
```

相關資料

- https://dotblogs.com.tw/maduka/2018/01/29/214811