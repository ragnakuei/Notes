# Sample01

```csharp
[ApiController]
[Route("api/[Controller]")]
public class CultureInfoController : ControllerBase
{
    [HttpGet]
    public IActionResult Index()
    {
        return Ok(new 
        {
            CurrentCulture = Thread.CurrentThread.CurrentCulture.ToString(),
            CurrentUICulture = Thread.CurrentThread.CurrentUICulture.ToString(),
        });
    }
}
```
