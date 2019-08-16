# Range

Range 的比較不限於數字，如果 Object 有實作 IComparable 也可以進行比較。

## InRange

判斷 actual 是否介於 low、high 中

```csharp
Assert.InRange<T>(T actual, T low, T high) where T : IComparable
Assert.InRange<T>(T actual, T low, T high, IComparer<T> comparer)
```

## NotInRange

判斷 actual 是否不介於 low、high 中

```csharp
Assert.NotInRange<T>(T actual, T low, T high) where T : IComparable
Assert.NotInRange<T>(T actual, T low, T high, IComparer<T> comparer)
```
