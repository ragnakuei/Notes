# 設定 Collation 的方式

注意：

```
所有 table 的 column，如果不指定 collation ，就會全部指定為 database 的 collationn
在建立 table 後，再修改 database 的 collation，就會導致 table columns 的 collation 與 database 的 collation 不一致

在建立 Table 之前，就要先設定好 Collation (特別是在 Ef Core 3 之前的版本，不要一次就 migration 全部的 dd)
否則字串欄位都有可能會有原本的 Collation 設定
```

## 在 Ef Core 3.1 

[如何在 EF Core 3.1 的 Code First 進行資料庫移轉時指定資料庫定序](https://blog.miniasp.com/post/2020/08/07/EF-Core-31-Code-First-DB-Migration-set-collation)

## 在 Ef Core 5.x (含)之後

提供 `UserCollation()` 來指定 Collation

DbContext.OnModelCreating()

```csharp
modelBuilder.UseCollation("Collation Name")
```

## 在 Ef Core 3.1 - 範例

將下述程式碼加到 .net core console 專案中

```csharp
public class TestDbContext : DbContext
{
    public TestDbContext(DbContextOptions<TestDbContext> options)
        : base(options)
    {
    }

    public DbSet<Test> Test { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        // optionsBuilder.AddInterceptors(new CreateDatabaseCollationInterceptor("Chinese_Taiwan_Stroke_CI_AS"));
        optionsBuilder.AddInterceptors(new CreateDatabaseCollationInterceptor("Chinese_Taiwan_Stroke_BIN"));
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
    }
}
```

```csharp
public class Test
{
    public int    Id   { get; set; }
    public string Name { get; set; }
}
```

```csharp
public class TestDbContextFactory : IDesignTimeDbContextFactory<TestDbContext>
{
    public TestDbContextFactory()
    {
    }

    public TestDbContext CreateDbContext(string[] args)
    {
        var connectionString = "Server=.\\mssql2017;Initial Catalog=Test;Trusted_Connection=True;";

        var optionBuilder = new DbContextOptionsBuilder<TestDbContext>().UseSqlServer(connectionString);

        return new TestDbContext(optionBuilder.Options);
    }
}
```

```csharp
public class CreateDatabaseCollationInterceptor : DbCommandInterceptor
{
    private readonly string _collation;

    public CreateDatabaseCollationInterceptor(string collation)
    {
        _collation = collation;
    }

    public override InterceptionResult<int> NonQueryExecuting(DbCommand command, CommandEventData eventData, InterceptionResult<int> result)
    {
        var pattern = @"^CREATE DATABASE (\[.*\])(.*)$";
        if (Regex.IsMatch(command.CommandText, pattern))
        {
            command.CommandText = Regex.Replace(command.CommandText, pattern, $"CREATE DATABASE $1 COLLATE {_collation} $2");
        }

        return result;
    }

    public override Task<InterceptionResult<int>> NonQueryExecutingAsync(DbCommand command, CommandEventData eventData, InterceptionResult<int> result, CancellationToken cancellationToken = default)
    {
        var pattern = @"^CREATE DATABASE (\[.*\])(.*)$";
        if (Regex.IsMatch(command.CommandText, pattern))
        {
            command.CommandText = Regex.Replace(command.CommandText, pattern, $"CREATE DATABASE $1 COLLATE {_collation} $2");
        }

        return Task.FromResult(result);
    }
}
```

執行 dotnet ef migration add

執行 dotnet ef database update -v

就會看到關鍵語法

```
Executing DbCommand [Parameters=[], CommandType='Text', CommandTimeout='60']
CREATE DATABASE [Test];
Executed DbCommand (454ms) [Parameters=[], CommandType='Text', CommandTimeout='60']
CREATE DATABASE [Test] COLLATE Chinese_Taiwan_Stroke_BIN ;
```

