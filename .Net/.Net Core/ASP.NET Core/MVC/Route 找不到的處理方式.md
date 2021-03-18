# Route 找不到的處理方式

## 方式一

```csharp
[Route("{*url}", Order = 999)]
public IActionResult CatchAll()
{
    Response.StatusCode = 404;
    return View("NotFound");
}
```
