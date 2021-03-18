# ControllerActionInvoker

Controller 預設呼叫 ControllerActionInvoker 來進行下一步有關 Action 的動作

## InvokeAction

可在 Controller 在呼叫 Action 前，先做統一的判斷

### FindAction

只會尋找 HttpGet 的 Action

```csharp
public override bool InvokeAction(ControllerContext controllerContext, string actionName)
{
    var controllerDescriptor = GetControllerDescriptor(controllerContext);

    var actionDescriptor = FindAction(controllerContext, controllerDescriptor, actionName);
}
```

### FindAction 只能抓出 HttpGet 的解決方式

從 ControllerDescriptor.GetCanonicalActions() 取出所有的 Action 後，再用 ActionName 來過濾 !

```csharp
public override bool InvokeAction(ControllerContext controllerContext, string actionName)
{
    var controllerDescriptor = GetControllerDescriptor(controllerContext);

    var actionDescriptor = FindAction(controllerContext, controllerDescriptor, actionName)
                        ?? controllerDescriptor.GetCanonicalActions()
                                               .FirstOrDefault(a => a.ActionName == actionName);
}
```