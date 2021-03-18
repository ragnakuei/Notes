# 預設 Exception Filter HandleErrorAttribute

內建的預設 Exception Filter 為 `HandleErrorAttribute`

在 MVC 內分為三個等級，由小至大分別說明

## Action

```csharp
[HandleError]
public ActionResult Index()
{
    return View();
}
```

---

## Controller

```csharp
[HandleError]
public class HomeController : Controller
{
	//Actions...
}
```

---

## Application

### 方式一

Global.asax.cs

```csharp
public class Global : HttpApplication
{
    void Application_Start(object sender, EventArgs e)
    {   
        // 應用程式啟動時執行的程式碼
        AreaRegistration.RegisterAllAreas();
        GlobalConfiguration.Configure(WebApiConfig.Register);

        // 註冊全域錯誤處理功能
        FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
        RouteConfig.RegisterRoutes(RouteTable.Routes);            
    }
}
```

FilterConfig.cs

```csharp
public class FilterConfig
{
    public static void RegisterGlobalFilters(GlobalFilterCollection filters)
    {
        filters.Add(new HandleErrorAttribute());
    }
}
```

---

### 方式二

```csharp
public class Global : HttpApplication
{
    void Application_Start(object sender, EventArgs e)
    {   
        // 應用程式啟動時執行的程式碼
        AreaRegistration.RegisterAllAreas();
        GlobalConfiguration.Configure(WebApiConfig.Register);
        FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
        RouteConfig.RegisterRoutes(RouteTable.Routes);

        // 註冊 使用 CustomerError
        GlobalFilters.Filters.Add(new HandleErrorAttribute());
    }
}
```