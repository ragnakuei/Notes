# 依照 URL 來 DI 不同的 Connection String

```cs
services.AddHttpContextAccessor();
services.AddScoped<TestRepository>();

services.AddDbContext<DbContext>((serviceProvider, options) =>
                                    {
                                        var httpContext = serviceProvider.GetService<IHttpContextAccessor>();

                                        var requestUrl = httpContext.HttpContext.Request.Path.ToString();

                                        var connectionStringName = requestUrl.StartsWith("/Test/A")
                                                                    ? "AConnection"
                                                                    : "BConnection";

                                        options.UseSqlServer(Configuration.GetConnectionString(connectionStringName));
                                    });
```


```cs
public class TestDbContext : DbContext
{
    public TestDbContext(DbContextOptions options)
        : base(options)
    {
    }
}

public class TestRepository
{
    private readonly DbContext _dbContext;

    public TestRepository(DbContext dbContext)
    {
        _dbContext = dbContext;

        Debug.WriteLine($"dbContext.Database.GetConnectionString():{dbContext.Database.GetConnectionString()}");
    }
}
```


```cs
[Route("[controller]")]
public class TestController : Controller
{
    private readonly TestRepository _repository;

    public TestController(TestRepository repository)
    {
        _repository = repository;
    }

    [HttpGet]
    [Route("[action]")]
    public IActionResult A()
    {
        return Ok();
    }

    [HttpGet]
    [Route("[action]")]
    public IActionResult B()
    {
        return Ok();
    }
}
```