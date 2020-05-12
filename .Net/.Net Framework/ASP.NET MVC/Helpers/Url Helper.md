# Url Helper

產生對應的 Url String

[UrlHelper Class (System.Web.Mvc)](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.mvc.urlhelper)

```csharp
Url.RouteUrl("Default",
          		new { action = "Index", controller = "Department", id = 1 }
)
```

/Department/Index/1

```csharp
Url.RouteUrl("Default",
		         new { action = "Index", controller = "Department", id = 1 }, 
             Request.Url.Scheme)
```

http 加上 /Department/Index/1

```csharp
Url.RouteUrl("Default",
		new { action = "Index", controller = "Department", id = 1
		}, "http", "sub.currentdomain.com")
```

- 待釐清
- http 加上 domain 加上 /Department/Index/1