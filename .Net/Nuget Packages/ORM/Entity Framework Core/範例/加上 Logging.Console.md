# 加上 Logging.Console

### 環境

Console

.Net Core 3.1

### 安裝套件

```
dotnet add package Microsoft.Extensions.Logging.Console
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.Extensions.Configuration
dotnet add package Microsoft.Extensions.Configuration.Json
dotnet add package Microsoft.Extensions.Options.ConfigurationExtensions
```

### C Sharp 語法

```csharp
using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;
using Microsoft.EntityFrameworkCore.Query.SqlExpressions;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace TestCustomDbFunctionForEfCore
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = DiFactory.GetService<TestDataBaseContext>();
            var customer = context.TableA
                                  .Where(t => EF.Functions.Like(t.Name, "%D%"))
                                  .Select(t => new
                                               {
                                                   Id       = t.Id,
                                                   Name     = t.Name,
                                                   JsonId   = TestDataBaseContext.JsonValue(t.JsonColumn, "$.Id"),
                                                   JsonName = TestDataBaseContext.JsonValue(t.JsonColumn, "$.Name")
                                               })
                                  .FirstOrDefault();

            Console.WriteLine(customer.Id);
            Console.WriteLine(customer.Name);
            Console.WriteLine(customer.JsonId);
            Console.WriteLine(customer.JsonName);
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

            // 加上 Log 至 Console 輸出的功能
            _services.AddLogging(configure => configure.AddConsole());

            _services.AddDbContext<TestDataBaseContext>(options => options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")))

                     // DbContext 增加 Logging 功能
                     .AddLogging();

            _provider = _services.BuildServiceProvider();
        }

        public static T GetService<T>()
        {
            return _provider.GetService<T>();
        }
    }


    public class TestDataBaseContext : DbContext
    {
        public TestDataBaseContext(DbContextOptions<TestDataBaseContext> options)
            : base(options)
        {
        }

        public DbSet<TableA> TableA { get; set; }

        [DbFunction("JSON_VALUE", "dbo")]
        public static string JsonValue(string column, [NotParameterized]string path) => throw new NotSupportedException();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<TableA>();

            modelBuilder.HasDbFunction(typeof(TestDataBaseContext).GetMethod(nameof(JsonValue)))
                        .HasTranslation(args => SqlFunctionExpression.Create("JSON_VALUE", args, typeof(string), null));
        }
    }

    public class TableA
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string JsonColumn { get; set; }
    }
}
```

### 新增 appsettings.json

要記得設定複製到編譯資料夾下

```json
{
    "ConnectionStrings": {
        "DefaultConnection": "Server=.\\mssql2017;Database=TestDataBase;Trusted_Connection=True;MultipleActiveResultSets=true"
    }
}
```

### SQL 語法

```sql
USE [TestDataBase]
GO

CREATE TABLE [dbo].[TableA]
(
    [Id]         [int]            NOT NULL,
    [Name]       [nvarchar](50)   NOT NULL,
    [JsonColumn] [nvarchar](1000) NULL,
    CONSTRAINT [PK_TableA] PRIMARY KEY CLUSTERED
        (
         [Id] ASC
        ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [TestDataBase].[dbo].[TableA] ([Id], [Name], [JsonColumn])
VALUES (1, N'A', N'{ "Id":1,"Name":"A" }');
INSERT INTO [TestDataBase].[dbo].[TableA] ([Id], [Name], [JsonColumn])
VALUES (2, N'AB', N'{ "Id":2,"Name":"AB" }');
INSERT INTO [TestDataBase].[dbo].[TableA] ([Id], [Name], [JsonColumn])
VALUES (3, N'ABC', N'{ "Id":3,"Name":"ABC" }');
INSERT INTO [TestDataBase].[dbo].[TableA] ([Id], [Name], [JsonColumn])
VALUES (4, N'BCDE', N'{ "Id":4,"Name":"BCDE" }');
INSERT INTO [TestDataBase].[dbo].[TableA] ([Id], [Name], [JsonColumn])
VALUES (5, N'CDEFG', N'{ "Id":5,"Name":"CDEFG" }');
```
