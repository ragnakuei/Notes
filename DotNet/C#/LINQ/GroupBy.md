# [GroupBy](https://docs.microsoft.com/zh-tw/dotnet/api/system.linq.enumerable.groupby?view=netframework-4.8)

## Overload 1

```csharp
GroupBy<TSource,TKey>(IEnumerable<TSource>
                    , Func<TSource,TKey>)
```

給定 Key Selector

## Overload 2

```csharp
GroupBy<TSource,TKey,TResult>(IEnumerable<TSource>
                            , Func<TSource,TKey>
                            , Func<TKey,IEnumerable<TSource>,TResult>)
```

給定 Key Selector 及 產生 TResult Func

這個效能會比 GroupBy().Select() 好

[CompareSample](../../Nuget%20Packages/BenchmarkDotNet/Sample/GroupBySelectVsGroupBy/)

```csharp
var ints = Enumerable.Range(1,100);

ints.GroupBy(i => i % 2 == 0,
             (i1, groupInts) => {
                 return (
                    Key : i1,
                    VALUE : groupInts.GroupBy(i2 => i2 % 3 == 0)
                                     .ToDictionary(kv2 => kv2.Key
                                                 , kv2 => kv2.ToArray())
                );
             })
.ToDictionary(
    kv => kv.Key,
    kv => kv.VALUE
).Dump();
```
