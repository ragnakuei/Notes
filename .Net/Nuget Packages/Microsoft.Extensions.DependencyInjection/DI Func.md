# DI Func

目前預期用來取代 di factory 的做法

func 就等於工廠模式內容的實作

```cs
services.AddScoped<TestResult1>();
services.AddScoped<TestResult2>();
services.AddScoped<Func<int, ITestResult>>(services => typeId => typeId switch
                                                                    {
                                                                        1 => services.GetService<TestResult1>(),
                                                                        2 => services.GetService<TestResult2>(),
                                                                        _ => throw new ArgumentOutOfRangeException(nameof(typeId), typeId, null)
                                                                    });
```

取用方式：

```cs
[ApiController]
[Route("[controller]")]
public class TestController : ControllerBase
{
    private readonly Func<int, ITestResult> _func;

    public TestController(Func<int, ITestResult> func)
    {
        _func = func;
    }

    [HttpGet]
    [Route("[action]")]
    public IActionResult Get(int typeId)
    {
        var result = _func.Invoke(typeId).GetResult();

        return Ok(result);
    }
}
```