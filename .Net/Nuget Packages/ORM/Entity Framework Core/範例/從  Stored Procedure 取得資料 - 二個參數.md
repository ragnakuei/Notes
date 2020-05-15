# 從  Stored Procedure 取得資料 - 二個參數

---

前置範例

[從  Stored Procedure 取得資料 - 單一參數](./從%20%20Stored%20Procedure%20取得資料%20-%20單一參數.md)

從 `FromSqlRaw()` 改成  `FromSqlInterpolated()` 並直接以 Interpolate 放入多個 SqlParameter

ParameterName  可視情況給定

> 不給定的話，預設會產生 @p0、@p1 ... 等 ParameterName 來 Mapping

### Stored Procedure

```sql
DROP PROCEDURE IF EXISTS [dbo].[usp_Test];  
GO

CREATE PROCEDURE [dbo].[usp_Test]
    @Id int,
	  @Name nvarchar(10)
AS
    SELECT @Id as Id,
	         @Name as Name
GO
```

### C#

```sql
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Linq;

namespace EfCoreStoredProcedure
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = DiFactory.GetService<NorthwindContext>();

            var parameterId = new SqlParameter
            {
                // ParameterName = "@Id", // 可以不用給，會變成 @p0
                DbType = System.Data.DbType.Int32,
                Value = 1
            };

            var parameterName = new SqlParameter
            {
                // ParameterName = "@Name",  // 可以不用給，會變成 @p1
                DbType = System.Data.DbType.AnsiString,
                Size = 10,
                Value = "A"
            };

            var result = context.usp_Tests.FromSqlInterpolated($"exec [dbo].[usp_Test] {parameterId}, {parameterName}")
                                .AsEnumerable()
                                .FirstOrDefault();

            Console.WriteLine(result.Id);
            Console.WriteLine(result.Name);
        }
    }

    public static class DiFactory
    {
        private static readonly ServiceProvider _provider;

        static DiFactory()
        {
            var _services = new ServiceCollection();

            var configuration = new ConfigurationBuilder()
                                .AddJsonFile("appsettings.json", optional: true)
                                .Build();
            _services.AddSingleton(_ => configuration);

            _services.AddDbContext<NorthwindContext>(
                options =>
                    options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

            _provider = _services.BuildServiceProvider();
        }

        public static T GetService<T>()
        {
            return _provider.GetService<T>();
        }
    }

    public class NorthwindContext : DbContext
    {
        public NorthwindContext(DbContextOptions<NorthwindContext> options) : base(options) { }
        public DbSet<usp_Test> usp_Tests { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
        }
    }

    // 用來對應 Stored Procedure 的 Entity Model
    public class usp_Test
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
```