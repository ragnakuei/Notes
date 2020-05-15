# 從  Stored Procedure 取得資料 - 單一參數

前置範例

[Northwind](./Northwind.md)

### 步驟

1. 建立 Stored Procedure
2. 建立對應 Stored Procedure 同名的 Entity Model
3. 以 DbContext.SpEntityModel.FromSqlRaw(sqlScript, sqlParameter) 的方式來取出結果

    FromSqlRaw 不支援 IQueryable<T> 接上 FirstOrDefault()，所以先透過 AsEnumerable() 再轉成 IEnumerable<T>，再取第一筆

### Stored Procedure

```sql
DROP PROCEDURE IF EXISTS [dbo].[usp_Test];  
GO

CREATE PROCEDURE [dbo].[usp_Test]
    @Id varchar(10)
AS
    SELECT @Id as Id;
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

            var parameter = new SqlParameter { 
                ParameterName = "@Id",
                DbType =  System.Data.DbType.AnsiString,
                Size = 10,
                Value = "1"
            };
            var result = context.usp_Tests.FromSqlRaw("exec [dbo].[usp_Test] @Id", parameter)
                                // 因為 FromSqlRaw 不支援 IQueryable<T> 接上 FirstOrDefault()，所以先轉成 IEnumerable<T>，再取第一筆
                                .AsEnumerable()        
                                .FirstOrDefault();
            Console.WriteLine(result.Id);
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

    public class usp_Test
    {
        public string Id { get; set; }
    }
}
```