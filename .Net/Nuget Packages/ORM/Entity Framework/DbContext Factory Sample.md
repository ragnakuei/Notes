# DbContext Factory Sample

假設組態檔的 connection string 的 name 是 `DbContextConnectionStringName`

```csharp
public static EfDbContext CreateEfDbContext(string connectionStringName = "DbContextConnectionStringName")
{
    var setting = ConfigurationManager.ConnectionStrings[connectionStringName];
    if (setting == null)
    {
        return null;
    }

    // 可以在這邊做連線字串的解密

    var result = new EfDbContext();
    result.Database.Connection.ConnectionString   = setting.ConnectionString;
    result.Configuration.AutoDetectChangesEnabled = false;
    result.Configuration.LazyLoadingEnabled       = false;
    result.Configuration.ProxyCreationEnabled     = false;
    return result;
}
```
