# Multiple Result Set

## 範例一

實作
- https://github.com/ragnakuei/EfMultipleResultSets

參考
- https://code.msdn.microsoft.com/windowsdesktop/Return-Multiple-Result-Set-33313dc5?fbclid=IwAR2cCs29NOocQJySE5ENo60d_QMKmL9WKJYUyrkTfUfCKX3oPQa1M4AJcwE
	

透過 IObjectContextAdapter.Translate<T>() 就可以依序將 DataSet 取出

```csharp
public ValueDTO Get(string value)
{
    var querySql = @"
DROP TABLE IF EXISTS #tempValues
create table #tempValues
(
[value] nvarchar(200)
)
INSERT INTO #tempValues(value)
SELECT @value
select *
from #tempValues
select *
from #tempValues
UNION ALL
select *
from #tempValues

DROP TABLE IF EXISTS #tempValues
";
    var parameter = new SqlParameter(nameof(value), value);

    var command = _dbContext.Database.Connection.CreateCommand(); 
    command.CommandText = querySql; 
    command.CommandType = CommandType.Text;
    command.Parameters.Clear();
    command.Parameters.Add(parameter);

    var result = new ValueDTO();
    result.Part1 = new List<QueryTempValue>();
    result.Part2 = new List<QueryTempValue>();
    
    _dbContext.Database.Connection.Open(); 
    using (var reader = command.ExecuteReader())
    {
        var objectContextAdapter = ((IObjectContextAdapter)_dbContext).ObjectContext;
        
        result.Part1 = objectContextAdapter.Translate<QueryTempValue>(reader).ToList();
        reader.NextResult();
        result.Part2 = objectContextAdapter.Translate<QueryTempValue>(reader).ToList();
    }
    _dbContext.Database.Connection.Close();

    return result;
}
```

## 範例二

```csharp
public GroupDetailViewModel GetDetail(int id)
{
    var sqlScript = @"
SELECT [g].[Id], [g].[Name], [g].[Created]
FROM [dbo].[Group] [g]
WHERE [Id] = @id

SELECT [u].[Name]
FROM [dbo].[UserGroup] [ug]
LEFT JOIN [dbo].[User] [u]
        ON [u].[Id] = [ug].[UserId]
WHERE [ug].[GroupId] = @id

SELECT [r].[Name]
FROM [dbo].[GroupRole] [gr]
LEFT JOIN [dbo].[Role] [r]
        ON [gr].[RoleId] = [r].[Id]
WHERE [gr].[GroupId] = @id
";
    var result = new GroupDetailViewModel();
    using (var dbContext = new EfDbContext())
    {

        var command = dbContext.Database.Connection.CreateCommand();
        command.CommandText = sqlScript;
        command.CommandType = CommandType.Text;
        command.Parameters.Clear();
        
        var parameter = new SqlParameter(parameterName : "id", value : id) { SqlDbType = SqlDbType.Int };
        command.Parameters.Add(parameter);

        dbContext.Database.Connection.Open();
        using (var reader = command.ExecuteReader())
        {
            var objectContextAdapter = ((IObjectContextAdapter)dbContext).ObjectContext;

            result.Group = objectContextAdapter.Translate<Group>(reader).FirstOrDefault();
            reader.NextResult();
            result.UserNames = objectContextAdapter.Translate<string>(reader).ToArray();
            reader.NextResult();
            result.RoleNames = objectContextAdapter.Translate<string>(reader).ToArray();
        }
    }
    return result;
}
```
