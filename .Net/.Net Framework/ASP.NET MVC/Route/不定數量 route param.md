# 不定數量 route param

## 範例 01

RouteConfig.cs 增加語法：

```cs
routes.MapRoute("Test",
                "Test/{*categories}",
                new { Controller = "Test", Action = "Index" });
```

對應的 Action 可以這樣寫：

```cs
public ActionResult Index(string categories)
{
    var array = categories.Split('/');
    return Json(array, JsonRequestBehavior.AllowGet);
}
```

## 範例 02

RouteConfig.cs 增加語法：

```cs
routes.MapRoute("TestIndex2",
                "Test/Index2/{*categories}",
                new { Controller = "Test", Action = "Index2" }
                )
        .RouteHandler = new CategoriesRouteHandler();
```

對應的 Action 可以這樣寫：

```cs
public ActionResult Index2(string   categories,
                            string[] categoryIds)
{
    var array = categories.Split('/');
    return Json(new
                {
                    categories,
                    categoryIds
                },
                JsonRequestBehavior.AllowGet);
}
```