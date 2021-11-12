# 讓 SQL 的變更可以變成 Queue 的情況

[範例](https://github.com/ragnakuei/MassChargeAndConsumeWithTransaction)

### 建立資料表 LockTable

```sql
CREATE TABLE [LockTable]
(
    [LockType] NVARCHAR(100) NOT NULL
        CONSTRAINT [PK_LockTable_1]
            PRIMARY KEY
)
GO
```

同時預先給定要變成 Queue 的 Key

```sql
INSERT INTO dbo.LockTable (LockType) 
VALUES (N'Prevent_TestDto_Update_AtSameTime');
```

### C# 端的語法

```cs
public class UserRepository
{
    private readonly IDbConnection _sqlConnection;

    public UserRepository(IDbConnection sqlConnection)
    {
        _sqlConnection = sqlConnection;
    }

    public Dto Get(int id)
    {
        var sql = @"
SELECT *
FROM [dbo].[User]
WHERE [Id] = @Id
";
        var param = new DynamicParameters();
        param.Add("id", id, DbType.Int64);

        var dto = _sqlConnection.QueryFirstOrDefault<Dto>(sql, param);
        return dto;
    }

    public void Charge(Dto dto)
    {
        var sql = PreventTestDtoUpdateAtSameTimeSqlScript()
                + @"
UPDATE [dbo].[User]
SET [Money] = [Money] + @Money
WHERE [Id] = @Id
";
        var param = new DynamicParameters();
        param.Add("Id",    dto.Id,    DbType.Int64);
        param.Add("Money", dto.Money, DbType.Int64);

        ExecuteWithTransaction(sql, param);
    }

    public void Consume(Dto dto)
    {
        var sql = PreventTestDtoUpdateAtSameTimeSqlScript()
                + @"
UPDATE [dbo].[User]
SET [Money] = [Money] - @Money
WHERE [Id] = @Id
";
        var param = new DynamicParameters();
        param.Add("Id",    dto.Id,    DbType.Int64);
        param.Add("Money", dto.Money, DbType.Int64);

        ExecuteWithTransaction(sql, param);
    }

    /// <summary>
    /// 取回 防止同時更新 TestDto 的 SQL Script
    /// </summary>
    private static string PreventTestDtoUpdateAtSameTimeSqlScript()
    {
        return @"
SELECT *
FROM [dbo].[LockTable] [LT]
WITH (UPDLOCK)
WHERE [LT].[LockType] = 'Prevent_TestDto_Update_AtSameTime'";
    }

    private void ExecuteWithTransaction(string sql, DynamicParameters param)
    {
        _sqlConnection.Open();

        using (var trans = _sqlConnection.BeginTransaction(IsolationLevel.ReadCommitted))
        {
            try
            {
                _sqlConnection.Execute(sql, param, trans);
                trans.Commit();
            }
            finally
            {
                if (_sqlConnection.State != ConnectionState.Closed)
                {
                    _sqlConnection.Close();
                }
            }
        }
    }
}
```