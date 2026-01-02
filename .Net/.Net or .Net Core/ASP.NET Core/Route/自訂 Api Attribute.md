# 自訂 Api Attribute

## 概述
本文件介紹如何自訂 API Attribute 與基於 Namespace 的路由約定，用於 ASP.NET Core 專案中。透過自訂的 Attribute 和 Convention，可以靈活地控制 API 路由的生成方式。

## 功能特色
- 使用 `ApiAttribute` 標記 Action 為 API
- 使用 `NamespaceRoutingConvention` 自動根據 Namespace 生成路由
- 支援 Controller 級別和 Action 級別的 API 標記
- 自動處理 Index Action 的預設路由

---

## ApiAttribute

### 說明
用來標示特定的 Action 是 API 端點。當 Action 被標記此 Attribute 時，會自動在路由前加上 `api` 前綴。
### 程式碼
```cs
/// <summary>
/// 用來標示 Action 是 API
/// </summary>
[AttributeUsage(AttributeTargets.Method)]
public class ApiAttribute : Attribute
{
}
```

### 使用方式
```cs
public class ProductController : Controller
{
    [Api]  // 此 Action 會自動加上 /api 前綴
    public IActionResult GetProducts()
    {
        // ...
    }
    
    public IActionResult Index()  // 不加 Api Attribute，不會有 /api 前綴
    {
        // ...
    }
}
```

---

## NamespaceRoutingConvention

### 說明
這是一個自訂的路由約定 (Convention)，用於根據 Controller 的 Namespace 自動生成路由規則。

### 主要功能
1. **基於 Namespace 生成路由**
   - 將 Namespace（跳過前兩層，通常是公司名稱和專案名稱）轉換為路由路徑
   - 例如：`TestProject.Controllers.Managed.Project.BasicController` → `/Managed/Project/Basic/[action]`

2. **Controller 名稱處理**
   - Controller 名稱以 "Api" 結尾時，自動在路由前加上 `api` 前綴，並移除 "Api" 字串
   - 例如：`ProductApiController` → `/api/Product/[action]`

3. **Action 級別 API 標記**
   - 支援使用 `[Api]` Attribute 標記個別 Action
   - 被標記的 Action 會自動加上 `api` 前綴

4. **Index Action 特殊處理**
   - 為名為 "Index" 的 Action 自動建立不含 action 名稱的路由
   - 例如：除了 `/Product/Index` 外，還可以透過 `/Product` 存取

5. **保留既有路由設定**
   - 如果 Action 已經有 RouteAttribute，會新增一個 Selector 而非覆蓋

### 程式碼
```cs
/// <summary>
/// 以 namespace (不包含 Assembly name) 來設定 Controller 與 Action 的 Route。
/// 直接針對各 Action 給定 RouteAttribute，而不是針對 Controller。
/// Sample：
///     TestProject.Controllers.Managed.Project.BasicController.Get => /Managed/Project/Basic/Get
///     TestProject.Controllers.Managed.Project.ProjectController.Get => /Managed/Project/Project/Get
/// </summary>
public class NamespaceRoutingConvention : Attribute, IControllerModelConvention
{
    public void Apply(ControllerModel controller)
    {
        // 如果該 controller 以 abstract 宣告，則略過
        var controllerType = controller.ControllerType;
        if (controllerType.IsAbstract)
            return;

        var namespc = controller.ControllerType.Namespace;
        if (namespc == null)
            return;

        var routeTemplateParts = namespc.Split('.').Skip(2).ToList();

        var controllerName = controller.ControllerName;

        var isApi = IsApiController(controllerName);
        if (isApi)
        {
            routeTemplateParts.Insert(0, "api");
            controllerName = controllerName.Replace("Api", string.Empty);
        }

        routeTemplateParts.Add(controllerName);
        routeTemplateParts.Add("[action]");

        // per Action
        foreach (var action in controller.Actions)
        {
            var actionRouteTemplateParts = routeTemplateParts.ToList();
            
            var isApiAction = IsApiAction(action);
            if (isApiAction)
            {
                actionRouteTemplateParts.Insert(0, "api");
            }

            // 如果 action 有設定 RouteAttribute
            var routeTemplate = string.Join('/', actionRouteTemplateParts);

            var attributeRouteModel = new AttributeRouteModel
                                      {
                                          Template = routeTemplate,
                                      };

            if (action.Selectors.Count                  == 1
             && action.Selectors[0].AttributeRouteModel == null)
            {
                // 如果 action 沒有設定 RouteAttribute
                action.Selectors[0].AttributeRouteModel = attributeRouteModel;
            }
            else
            {
                // 如果 action 有設定 RouteAttribute，就新增一個 Selector
                action.Selectors.Add(new SelectorModel
                                     {
                                         AttributeRouteModel = attributeRouteModel
                                     });
            }

            if (action.ActionName == "Index")
            {
                var indexRouteTemplate = string.Join('/', routeTemplateParts.Where(r => r != "[action]"));

                // 如果 action 是 Index，就新增一個 Selector，不包含 [action]
                action.Selectors.Add(new SelectorModel
                                     {
                                         AttributeRouteModel = new AttributeRouteModel
                                                               {
                                                                   Template = indexRouteTemplate
                                                               }
                                     });
            }
        }
    }

    private static bool IsApiController(string controllerName)
    {
        return controllerName.EndsWith("Api");
    }

    /// <summary>
    /// 以 Api Attrbute 來判斷是否為 API Action
    /// </summary>
    /// <param name="action"></param>
    private static bool IsApiAction(ActionModel action)
    {
        var apiAttribute = action.ActionMethod.GetCustomAttributes(typeof(ApiAttribute), false);
        var isApiAction  = apiAttribute.Length > 0;
        return isApiAction;
    }
}
```

---

## 路由生成範例

### 範例 1：一般 Controller
```cs
// Namespace: TestProject.Controllers.Managed.Project
public class BasicController : Controller
{
    public IActionResult Get() { }  
    // 路由: /Managed/Project/Basic/Get
    
    public IActionResult Index() { }  
    // 路由: /Managed/Project/Basic/Index 或 /Managed/Project/Basic
}
```

### 範例 2：API Controller（Controller 名稱以 Api 結尾）
```cs
// Namespace: TestProject.Controllers.Product
public class ProductApiController : Controller
{
    public IActionResult Get() { }  
    // 路由: /api/Product/Get
    
    public IActionResult Create() { }  
    // 路由: /api/Product/Create
}
```

### 範例 3：使用 ApiAttribute 標記 Action
```cs
// Namespace: TestProject.Controllers.Order
public class OrderController : Controller
{
    public IActionResult Index() { }  
    // 路由: /Order/Index 或 /Order
    
    [Api]
    public IActionResult GetList() { }  
    // 路由: /api/Order/GetList
    
    [Api]
    public IActionResult GetDetail(int id) { }  
    // 路由: /api/Order/GetDetail
}
```

### 範例 4：複雜 Namespace
```cs
// Namespace: MyCompany.WebApp.Controllers.Admin.User.Management
public class AccountController : Controller
{
    public IActionResult List() { }  
    // 路由: /Admin/User/Management/Account/List
    
    public IActionResult Index() { }  
    // 路由: /Admin/User/Management/Account/Index 或 /Admin/User/Management/Account
}
```

---

## 註冊方式

在 `Program.cs` 或 `Startup.cs` 中註冊此 Convention：

```cs
// ASP.NET Core 6+ (Program.cs)
builder.Services.AddControllersWithViews(options =>
{
    options.Conventions.Add(new NamespaceRoutingConvention());
});

// 或
builder.Services.AddControllers(options =>
{
    options.Conventions.Add(new NamespaceRoutingConvention());
});
```

```cs
// ASP.NET Core 5 或更早版本 (Startup.cs)
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllersWithViews(options =>
    {
        options.Conventions.Add(new NamespaceRoutingConvention());
    });
}
```

---

## 注意事項

1. **Abstract Controller**
   - 抽象類別 (abstract class) 會被自動略過，不會生成路由

2. **Namespace 層級**
   - Convention 會跳過 Namespace 的前兩層（通常是公司名稱和專案類型）
   - 例如：`CompanyName.ProjectName.Controllers.XXX` 會從 `Controllers` 開始

3. **RouteAttribute 優先權**
   - 如果 Action 已有 `[Route]` Attribute，此 Convention 會新增額外的路由選項，而不會覆蓋原有設定

4. **API 前綴優先順序**
   - Action 層級的 `[Api]` Attribute 優先於 Controller 名稱規則
   - Controller 名稱以 "Api" 結尾時，所有 Action 都會加上 `api` 前綴
   - 若要在 API Controller 中排除特定 Action，需要額外實作邏輯

5. **Index Action**
   - Index Action 會自動生成兩個路由：含 action 名稱和不含 action 名稱

---

## 適用場景

- 大型專案需要統一的路由規則
- 希望根據專案結構（Namespace）自動生成路由
- 需要混合 MVC 和 API 路由在同一個專案中
- 希望簡化路由配置，減少重複的 `[Route]` Attribute

---

## 相關參考

- [IControllerModelConvention Interface](https://learn.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.applicationmodels.icontrollermodelconvention)
- [Application Model in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/mvc/controllers/application-model)
- [Routing in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/routing)