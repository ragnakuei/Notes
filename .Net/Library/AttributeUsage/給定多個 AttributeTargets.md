# 給定多個 AttributeTargets

以 `|` 來串接多個 AttributeTargets

```csharp
[AttributeUsage(AttributeTargets.Method | AttributeTargets.Class, AllowMultiple = true)]
public class InvokeConditionAttribute : ActionFilterAttribute
{
    ...
}
```