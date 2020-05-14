# Multiple Result Set

實作

[Github](https://github.com/ragnakuei/EfCoreMultipleResultSets)

因為目前 ef core 不支援類似的語法

- [https://github.com/aspnet/EntityFrameworkCore/issues/8127?fbclid=IwAR0VGOrnV04byJe2LQxGhLU1rRkiIIg_AFdxAF6h-KpquG2e2Z5F7txX94Y](https://github.com/aspnet/EntityFrameworkCore/issues/8127?fbclid=IwAR0VGOrnV04byJe2LQxGhLU1rRkiIIg_AFdxAF6h-KpquG2e2Z5F7txX94Y)

所以先用 ado.net 的方式取出多個 data set

DbDataReader.Translate<T>() 的功用就是將 IDataRecords 的資料轉成 IList<T>

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

    var command = _dbContext.Database.GetDbConnection().CreateCommand(); 
    command.CommandText = querySql; 
    command.CommandType = CommandType.Text;
    command.Parameters.Clear();
    command.Parameters.Add(parameter);

    var result = new ValueDTO();
    result.Part1 = new List<QueryTempValue>();
    result.Part2 = new List<QueryTempValue>();
    
    // _dbContext.Database.OpenConnection();
    _dbContext.Database.GetDbConnection().Open(); 
    using (var reader = command.ExecuteReader())
    {
        result.Part1 = reader.Translate<QueryTempValue>();
        result.Part2 = reader.Translate<QueryTempValue>();
    }
    // _dbContext.Database.CloseConnection();
    _dbContext.Database.GetDbConnection().Close();

    return result;
}
```

DbDataReader.Translate<T>()

Materializer.Materialize() 就是用來 IDataRecord 轉成 T

```csharp
public static class DataRecordExtensions
{
    private static readonly ConcurrentDictionary<Type, object> _materializers = new ConcurrentDictionary<Type, object>();
    public static IList<T> Translate<T>(this DbDataReader reader) where T : new()
    {
        var materializer = (Func<IDataRecord, T>)_materializers.GetOrAdd(typeof(T), (Func<IDataRecord, T>)Materializer.Materialize<T>);
        // var materializer2 = new Func<IDataRecord, T>((IDataRecord dataRecord) => Materializer.Materialize<T>(dataRecord));
        return Translate(reader, materializer, out var hasNextResults);
    }

    private static IList<T> Translate<T>(this DbDataReader reader, Func<IDataRecord, T> objectMaterializer)
    {
        return Translate(reader, objectMaterializer, out var hasNextResults);
    }

    private static IList<T> Translate<T>(this DbDataReader reader, Func<IDataRecord, T> objectMaterializer, out bool hasNextResult)
    {
        var results = new List<T>();
        while (reader.Read())
        {
            var record = (IDataRecord)reader;
            var obj    = objectMaterializer.Invoke(record);
            results.Add(obj);
        }
        hasNextResult = reader.NextResult();
        return results;
    }
}
```

Materializer.Materialize()

透過反射來達成 ORM 的 mapping 的動作

當 Property 有特定的 Attribute 時，就不會進行給值的動作

```csharp
public class Materializer
{
    public static T Materialize<T>(IDataRecord record) where T : new()
    {
        var t = new T();
        foreach (var prop in typeof(T).GetProperties())
        {
            // 1). If entity reference, bypass it.
            if (prop.PropertyType.Namespace == typeof(T).Namespace)
            {
                continue;
            }
            // 2). If collection, bypass it.
            if (prop.PropertyType != typeof(string) && typeof(IEnumerable<>).IsAssignableFrom(prop.PropertyType))
            {
                continue;
            }
            // 3). If property is NotMapped, bypass it.
            if (Attribute.IsDefined(prop, typeof(NotMappedAttribute)))
            {
                continue;
            }
            var dbValue = record[prop.Name];
            if (dbValue is DBNull) continue;
            if (prop.PropertyType.IsConstructedGenericType &&
                prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>))
            {
                var baseType  = prop.PropertyType.GetGenericArguments()[0];
                var baseValue = Convert.ChangeType(dbValue, baseType);
                var value     = Activator.CreateInstance(prop.PropertyType, baseValue);
                prop.SetValue(t, value);
            }
            else
            {
                var value = Convert.ChangeType(dbValue, prop.PropertyType);
                prop.SetValue(t, value);
            }
        }
        return t;
    }
}
```