# 套用 Attribute Route

1. 在 AreaRegistration 的對應設定檔加上指定語法

    ```csharp
    public class BlogsAreaRegistration : AreaRegistration
    {
        public override string AreaName => "Blogs";

        public override void RegisterArea(AreaRegistrationContext context)
        {
            // 要加上這一行
            context.Routes.MapMvcAttributeRoutes();

            context.MapRoute(
                name: "Blogs",
                url: "Blogs/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new [] { "TestAreas.Areas.Blogs.Controllers" }
            );
        }
    }
    ```
1. 在 Controller 上加上 RouteArea
1. 在 Action 上加上 Route
```csharp
// 要加上這一行
[RouteArea("Blogs")]
public class HomeController : Controller
{
    public ActionResult Index()
    {
        return View();
    }

    // 原本預期要加的
    [HttpPost, Route("api/Home/PostIndex")]
    public ActionResult PostIndex()
    {
        return Json();
    }
}
```

1. 使用 Url.Action("PostIndex", "Home") 就可以取出 Blogs/api/Home/PostIndex

    > 注意：以上例來說，如果只要取出 api/Home/PostIndex 的話，要用以下的方式


## 讓 Attribute Route 不讀到 Area Name

- 只要在取 Route 時，讓 Area Name 變成空字串就可以了 !
- RouteArea 要給定 AreaPrefix = ""

```csharp
[RouteArea("Blogs", AreaPrefix = "")]
public class HomeController : Controller
{
    public ActionResult Index()
    {
        return View();
    }


    [HttpPost, Route("api/Home/PostIndex")]
    public ActionResult PostIndex()
    {
        return View();
    }
}
```

這樣就可以讓 Url.Action("PostIndex", "Home") 就可以取出 /api/Home/PostIndex 的值