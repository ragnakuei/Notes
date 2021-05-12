# delegate ref parameter

- 彌補 Action\<T>  Func<T, TResult> 無法套用 ref 的語法

## 範例一

[檔案一](https://github.com/ragnakuei/KueiExtensions/blob/master/KueiExtensions.Dapper/QueryMultipleBuilderOfT.cs#L32)

[檔案二](https://github.com/ragnakuei/KueiExtensions/blob/master/KueiExtensions.Dapper/QueryMultipleHandler.cs#L38)

宣告

- 宣告的 delegate 可以具有 ref parameter
- ReaderAction 可視為新的型別

```csharp
public delegate void ReaderAction(ref T t, SqlMapper.GridReader reader);

private readonly List<ReaderAction> _readerActions = new();

public QueryMultipleBuilderWithFunc<T> Read(ReaderAction readerAction)
{
    _readerActions.Add(readerAction);

    return this;
}

public T Query(List<ReaderAction> readerActions)
{
    var result = new T();

    using (_dbConnection)
    {
        var reader = _dbConnection.QueryMultiple(_sql, _param);

        foreach (var readerAction in readerActions)
        {
            readerAction(ref result, reader);
        }
    }

    return result;
}

```

呼叫

- 與原本 Action\<T>  Func<T, TResult> 不同的是，參數必須給定型別 及 變數名

```csharp
var a = dbConnection.MultipleResult<A>(sql)
                    .Read((ref A a, SqlMapper.GridReader reader) => a = reader.ReadFirstOrDefault<A>())
                    .Read((ref A a, SqlMapper.GridReader reader) => a.Details = reader.Read<ADetail>().ToArray())
                    .Query();
```
