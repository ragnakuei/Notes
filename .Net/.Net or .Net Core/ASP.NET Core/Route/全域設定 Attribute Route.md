# 全域設定 Attribute Route

目的：

資料夾存放路徑反映在 url 上，省去逐一設定 RouteAttribute 的麻煩。

規則：

1. 當 HomeController 的 namespace 為 Assembly.Controllers.A.B 時，其 Attribute Route 要給定 [Route(“A/B/[controller]”)]
1. Api 使用的 Controller 要以 ApiController 結尾
1. 當 HomeApiController 的 namespace 為 Assembly.Controllers.A.B 時，其 Attribute Route 要給定 [Route(“api/A/B/[controller]”)]

Program.cs

```cs
builder.Services.AddControllersWithViews(options =>
                                         {
                                             // 1. 指定 NamespaceRoutingConvention
                                             options.Conventions.Add(new NamespaceRoutingConvention());
                                         });

// ....

// 2，要加這一行，但沒有意羲，原因是設定了 Attribute Route 後，就不會使用 Tradition Route
app.MapControllerRoute(name: "default", pattern: "{controller=Home}/{action=Index}/{id?}");
```

NamespaceRoutingConvention.cs

程式邏輯

1. 先設定 Controller Attribute Route，再設定 Action Attribute Route
1. 如果 Action 是 Index，則再增加一組 [Route(““)]
1. 如果 Controller 名稱是 ApiController，則該 Action Route 為 api 開頭

```cs
/// <summary>
/// 以 namespace (不包含 Assembly name) 來設定 Controller 與 Action 的 Route。
/// 直接針對各 Action 給定 RouteAttribute，而不是針對 Controller。
/// </summary>
public class NamespaceRoutingConvention : Attribute, IControllerModelConvention
{
    public void Apply(ControllerModel controller)
    {
        var namespc = controller.ControllerType.Namespace;
        if (namespc == null)
            return;

        var controllerRouteTemplate = string.Join('/', namespc.Split('.').Skip(2));

        var controllerName = controller.ControllerName;
        var isApi          = controllerName.EndsWith("Api");

        if (isApi)
        {
            controllerRouteTemplate = "api/" + controllerRouteTemplate;
            controllerName          = controllerName.Replace("Api", string.Empty);
        }

        controllerRouteTemplate += $"/{controllerName}";
        var controllerRouteAttribute = new AttributeRouteModel
                                       {
                                           Template = controllerRouteTemplate
                                       };

        // controller
        if (controller.Selectors.Count == 1 && controller.Selectors[0].AttributeRouteModel == null)
        {
            controller.Selectors[0].AttributeRouteModel = controllerRouteAttribute;
        }
        else
        {
            controller.Selectors.Add(new SelectorModel
                                     {
                                         AttributeRouteModel = controllerRouteAttribute
                                     });
        }

        // per Action
        foreach (var action in controller.Actions)
        {
            // 如果 action RouteAttribute [Route("[action]")]
            var actionAttributeRoute = new AttributeRouteModel
                                       {
                                           Template = "[action]"
                                       };

            if (action.Selectors.Count                  == 1
             && action.Selectors[0].AttributeRouteModel == null)
            {
                // 如果 action 沒有設定 RouteAttribute
                action.Selectors[0].AttributeRouteModel = actionAttributeRoute;
            }
            else
            {
                // 如果 action 有設定 RouteAttribute，就新增一個
                action.Selectors.Add(new SelectorModel
                                     {
                                         AttributeRouteModel = actionAttributeRoute
                                     });
            }

            if (action.ActionName == "Index")
            {
                // 如果 action 是 Index，就新增一個 Selector [Route("")]
                action.Selectors.Add(new SelectorModel
                                     {
                                         AttributeRouteModel = new AttributeRouteModel
                                                               {
                                                                   Template = ""
                                                               }
                                     });
            }
        }
    }
}
```
