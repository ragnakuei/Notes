# Asp.Net Core MVC 範例

[範例](https://github.com/ragnakuei/ModelBindingSecureString/blob/master/ModelBindingSecureString/Controllers/HomeController.cs)

Controller Actions 如下：

```csharp
[HttpGet]
public IActionResult Index()
{
    return View();
}

[HttpPost]
public IActionResult Index(ViewModel vm)
{
    var plainText = SecureStringToString(vm.Password);

    return View(vm);
}

/// <summary>
/// 把 SecureString 轉回 PlainText
/// </summary>
private string SecureStringToString(SecureString value)
{
    IntPtr valuePtr = IntPtr.Zero;
    try
    {
        valuePtr = Marshal.SecureStringToGlobalAllocUnicode(value);
        return Marshal.PtrToStringUni(valuePtr);
    }
    finally
    {
        Marshal.ZeroFreeGlobalAllocUnicode(valuePtr);
    }
}
```

ViewModel 如下：

```csharp
public class ViewModel
{
    public string Account { get; set; }

    [DataType(DataType.Password)]
    [BindProperty(BinderType = typeof(SecureStringBinder))]
    public SecureString Password { get; set; }
}
```

其中 SecureStringBinder 如下：

```csharp
public class SecureStringBinder : IModelBinder
{
    public Task BindModelAsync(ModelBindingContext bindingContext)
    {
        var valueProviderResult = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);

        var value = valueProviderResult.FirstValue;

        var propertyValue = new SecureString();

        foreach (var c in value)
        {
            propertyValue.AppendChar(c);
        }

        bindingContext.Result = ModelBindingResult.Success(propertyValue);

        return Task.CompletedTask;
    }
}
```

View 如下：

```csharp
@model ModelBindingSecureString.Controllers.ViewModel

<form method="post">
    <p>帳號：</p>
    <p><input asp-for="Account"></p>
    <p>密碼：</p>
    <p><input asp-for="Password" value=""></p>
    <button type="submit">送出</button>
</form>

```