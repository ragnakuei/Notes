# Microsoft.Data.SqlClient

為 System.Data.SqlClient 的替代套件

---

Q：出現 此憑證鏈結是由不受信任的授權單位發出的 的錯誤訊息 !

A：連線字串，加上 TrustServerCertificate=true 就可以，但建議只用於開發環境，因為這項設定會忽略連到 DB 的 SSL Certificate Validation !

### DbConnectionFactory 範例

```csharp
/// <summary>
/// 提供各個連線字串對應的 DbConnection
/// </summary>
/// <remarks>
/// 1. 從 DbConnectionFactory 控管 Scoped / Transient 的所有 DbConnection
/// 2. 外部呼叫都不需要使用 using，Dispose 由 DbConnectionFactory 統一控管
/// 3. scoped IDbConnection 不需要再做 Open()，統一由 DbConnectionFactory 處理 !
/// </remarks>
public class DbConnectionFactory : IDisposable
{
    private readonly IConfiguration                    _configuration;
    private readonly Dictionary<string, IDbConnection> _scopedDbConnections    = new();
    private readonly List<IDbConnection>               _transientDbConnections = new();

    public DbConnectionFactory(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    #region Scoped

    /// <summary>
    /// Scoped
    /// </summary>
    public IDbConnection GetScopedDefault() => CreateScoped("Default");

    /// <summary>
    /// Scoped
    /// </summary>
    public IDbConnection GetScopedLog() => CreateScoped("LogDB");

    private IDbConnection CreateScoped(string connectionStringKey)
    {
        if (!_scopedDbConnections.ContainsKey(connectionStringKey))
        {
            var dbConecction = CreateDbConnection(connectionStringKey);

            _scopedDbConnections.Add(connectionStringKey, dbConecction);
        }

        var scopedDbConnection = _scopedDbConnections[connectionStringKey];

        if (scopedDbConnection.State == ConnectionState.Closed) scopedDbConnection.Open();

        return scopedDbConnection;
    }

    #endregion

    #region Transient 非同步

    public IDbConnection GetTransientDefault() => CreateTransient("Default");

    public IDbConnection GetTransientLog() => CreateTransient("LogDB");

    private IDbConnection CreateTransient(string connectionStringKey)
    {
        var transientDbConnection = CreateDbConnection(connectionStringKey);
        _transientDbConnections.Add(transientDbConnection);
        return transientDbConnection;
    }

    #endregion

    private SqlConnection CreateDbConnection(string connectionStringKey)
    {
        var connectionString = _configuration.GetConnectionString(connectionStringKey);
        if (string.IsNullOrWhiteSpace(connectionString))
        {
            throw new Exception($"{connectionStringKey} Connection string not found");
        }

        var dbConnection = new SqlConnection(connectionString);
        return dbConnection;
    }

    public void Dispose()
    {
        foreach (var kv in _scopedDbConnections)
        {
            kv.Value.Dispose();
        }

        foreach (var transientDbConnection in _transientDbConnections)
        {
            transientDbConnection.Dispose();
        }
    }
}
```
