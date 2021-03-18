# 擴充 ControllerActionInvoker

在建立完畢 Controller 後，就會呼叫 ControllerActionInvoker 來執行 Action


```csharp
public class BaseController : Controller
{
    // 使用指定的 ActionInvoker
    protected override IActionInvoker CreateActionInvoker()
    {
        return new CustomControllerActionInvoker();
    }
}

public class CustomControllerActionInvoker : ControllerActionInvoker
{
    
}
```
