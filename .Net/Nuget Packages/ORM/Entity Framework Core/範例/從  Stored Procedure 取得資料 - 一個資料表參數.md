# 從  Stored Procedure 取得資料 - 一個資料表參數

---

前置範例

[從  Stored Procedure 取得資料 - 單一參數](./從%20%20Stored%20Procedure%20取得資料%20-%20單一參數.md)

### User Defined Table Type

```sql
IF type_id('[dbo].[tIdName]') IS NOT NULL
        DROP TYPE [dbo].[tIdName];

CREATE TYPE [dbo].[tIdName] AS TABLE
    (
        [Id] int,
        [Name] nvarchar(10)
    );
```

### Stored Procedure

```sql
DROP PROCEDURE IF EXISTS [dbo].[usp_Test];  
GO

CREATE PROCEDURE [dbo].[usp_Test]
    @input [dbo].[tIdName] READONLY
AS
    SELECT * from @input
GO
```

### C#

```csharp
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Data;
using System.Linq;

namespace EfCoreStoredProcedure
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = DiFactory.GetService<NorthwindContext>();

            var parameterDataTable = new SqlParameter
            {
                ParameterName = "@input",
                SqlDbType = SqlDbType.Structured,
                TypeName = "[dbo].[tIdName]",
                Value = GenerateDataTable()
            };

            var result = context.usp_Tests.FromSqlInterpolated($"exec [dbo].[usp_Test] {parameterDataTable}")
                                .AsEnumerable();

            foreach (var item in result)
            {
                Console.WriteLine(item.Id);
                Console.WriteLine(item.Name);
            }
        }

        private static DataTable GenerateDataTable()
        {
            var result = new DataTable();
            result.Columns.Add("Id", typeof(int));
            result.Columns.Add("Name", typeof(string));

            var row = result.NewRow();
            row[0] = 1;
            row[1] = "A";
            result.Rows.Add(row);

            row = result.NewRow();
            row[0] = 2;
            row[1] = "B";
            result.Rows.Add(row);

            return result;
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
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
```