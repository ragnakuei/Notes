# 明確指定 View 檔案

```csharp
public class TestBController : Controller
{
    // GET: TestBController
    public ActionResult Index()
    {
        return View("~/Views/FunctionB/TestB/Index.cshtml");
    }
}
```

