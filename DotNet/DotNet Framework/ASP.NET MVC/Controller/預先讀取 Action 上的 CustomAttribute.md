# 預先讀取 Action 上的 CustomAttribute

在了解 [Controller](./Controller.md) 可以預先處理 Action 的方式後，因為考量到 CustomAttribute 可以同時有多個，所以使用 `BaseController.OnActionExecuted()` 方式來實作

---

## ControllerActionInvoker

```csharp
public class CustomControllerActionInvoker : ControllerActionInvoker
{
    public override bool InvokeAction(ControllerContext controllerContext, string actionName)
    {
        ValidateCustomAuthorize(controllerContext, actionName);

        return base.InvokeAction(controllerContext, actionName);
    }

    /// <summary>
    /// 驗証是否符合 CustomAuthorizeAttribute 資格
    /// </summary>
    private void ValidateCustomAuthorize(ControllerContext controllerContext, string actionName)
    {
        ControllerDescriptor controllerDescriptor = this.GetControllerDescriptor(controllerContext);
        ActionDescriptor action = this.FindAction(controllerContext, controllerDescriptor, actionName);
        var customAuthorizeAttributes = action.GetCustomAttributes(typeof(CustomAuthorizeAttribute), true).Cast<CustomAuthorizeAttribute>();

        if (HttpContext.Current.User.Identity is CustomIdentity userIdentity)
        {
            var authRepository = DiFactory.GetService<IAuthRepository>();
            var dto = new AuthDto
            {
                UserId = userIdentity.UserId,
                CustomAuthorizeAttributes = customAuthorizeAttributes
            };
            if (authRepository.Auth(dto) == false)
            {
                throw new CustomException { ErrorCode = 401};
            }
        }
    }
}
```

---

## Controller

```csharp
public class MemberController : BaseController
{
    [CustomAuthorize("Test1")]
    [CustomAuthorize("Test2", "TestAction")]
    public ActionResult Index()
    {
        
        
        var identity = User.Identity as FormsIdentity;
        ViewBag.user = identity?.Name;

        return View();
    }
}
```

---

## CustomAuthorizeAttribute

```csharp
[AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
public class CustomAuthorizeAttribute : Attribute
{
    public CustomAuthorizeAttribute(string function)
    {
        Function = function;
    }

    public CustomAuthorizeAttribute(string function, string action)
    {
        Function = function;
        Action = action;
    }

    public string Action { get; }
    public string Function { get; }
}
```







---

參考資料
- [利用Attribute設定頁面的Title](https://dotblogs.com.tw/lastsecret/2011/12/05/60687)