# Transaction




#### 搭配 UpdLock

如果只是單純執行 SQL 語法，只需要執行 IDbConnextion.Execute() 就夠了

用 IDbConnextion.Execute() 反而會出現 Exception

錯誤訊息為：
```
The transaction operation cannot be performed because there are pending requests working on this transaction.
```

```cs
public void Consume(Dto dto)
{
    var sql = @"
SELECT *
FROM [dbo].[LockTable] [LT]
WITH (UPDLOCK)
WHERE [LT].[LockType] = 'Prevent_TestDto_Update_AtSameTime'

UPDATE [dbo].[User]
SET [Money] = [Money] - @Money
WHERE [Id] = @Id
";
    var param = new DynamicParameters();
    param.Add("Id",    dto.Id,    DbType.Int64);
    param.Add("Money", dto.Money, DbType.Int64);

    ExecuteWithTransaction(sql, param);
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
```

