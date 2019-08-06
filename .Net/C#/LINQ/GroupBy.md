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

[Sample](../../Nuget\ Packages/BenchmarkDotNet/Sample/GroupBySelectVsGroupBy/)
