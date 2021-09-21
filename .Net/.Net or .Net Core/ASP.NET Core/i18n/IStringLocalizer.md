# IStringLocalizer

如果要讀取 request header Accept-Language 做為指定語系的方式，可參考 [AddLocalization](./AddLocalization.md) 設定

## 從 Resource File 取出指定語系的 Key-Value

以 Constructor DI IStringLocalizer\<T> 指定的 Resource File

```csharp
[ApiController]
[Route("api/[controller]")]
public class TestController : ControllerBase
{
    private readonly IStringLocalizer<SharedResource> _localizer;

    public TestController(IStringLocalizer<SharedResource> localizer)
    {
        _localizer = localizer;
    }

    [HttpGet]
    public IActionResult Index()
    {
        return Ok(new
        {
            Hello = _localizer["Hello"].Value
        });
    }
}
```