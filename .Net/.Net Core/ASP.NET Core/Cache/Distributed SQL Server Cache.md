# [Distributed SQL Server Cache](https://docs.microsoft.com/zh-tw/aspnet/core/performance/caching/distributed#distributed-sql-server-cache)

[範例](https://github.com/ragnakuei/AspNetCoreDistributedSqlServerCacheAndSession)

## 步驟

1. 前置動作

    ```
    dotnet tool install --global dotnet-sql-cache
    ```

1. 先在指定的 DataBase 內建立 DB `DistCache`

1. 透過 dotnet tool 建立 Table Schema

    ```
    dotnet sql-cache create "Data Source=.\MSSQL2017;Initial Catalog=DistCache;Integrated Security=True;" dbo CacheTable
    ```

1. 安裝套件 `Microsoft.Extensions.Caching.SqlServer`
1. appsettings.json

    設定連線字串

    ```json
    "ConnectionStrings": {
        "DistCache_ConnectionString" : "Server=.\\mssql2017;Database=DistCache;Trusted_Connection=True;MultipleActiveResultSets=true"
    }
    ```

1. StartUp.ConfigureServices

    ```csharp
    // 此行可以不用
    // services.AddDistributedMemoryCache(options => { });

    services.AddDistributedSqlServerCache(options =>
                                            {
                                                options.ConnectionString = Configuration.GetConnectionString("DistCache_ConnectionString");
                                                options.SchemaName       = "dbo";
                                                options.TableName        = "CacheTable";

                                                // options.DefaultSlidingExpiration  // 預設二十分鐘
                                                // options.ExpiredItemsDeletionInterval // 預設三十分鐘後會刪除
                                            });
    ```

1. C# 語法

    ```csharp
    public class HomeController : Controller
    {
        private readonly IDistributedCache _cache;

        public HomeController(IDistributedCache cache)
        {
            _cache           = cache;
        }

        public IActionResult Index()
        {
            _cache.Set("Test", Encoding.UTF8.GetBytes(DateTime.Now.ToString()));
            ViewBag.CacheData = Encoding.UTF8.GetString(_cache.Get("Test"));
            return View();
        }
    }
    ```
