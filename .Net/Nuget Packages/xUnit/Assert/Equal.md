# Equal

比較 expected 與 actual 是否相等。浮點數可傳入精準度。

```csharp
Assert.Equal(double expected, double actual, int precision)
Assert.Equal(decimal expected, decimal actual, int precision)
```

比較二個物件是否相等

> 無法比較匿名型別。

> 參考型別預設比較的是 instance 位址，如果需要欄位比較，要給定 comparer。

```csharp
Assert.Equal<T>(T expected, T actual)
Assert.Equal<T>(T expected, T actual, IEqualityComparer<T> comparer)
```

## StrictEqual

以 EqualityComparer<T>.Default 呼叫 Assert.Equal<T>(T expected, T actual, IEqualityComparer<T> comparer)

```csharp
Assert.StrictEqual<T>(T expected, T actual)
```

## NotEqual

```csharp
Assert.NotEqual<T>(T expected, T actual)
Assert.NotEqual<T>(T expected, T actual, IEqualityComparer<T> comparer)
Assert.NotEqual(double expected, double actual, int precision)
Assert.NotEqual(decimal expected, decimal actual, int precision)
```

## NotStrictEqual

以 EqualityComparer<T>.Default 呼叫 Assert.NotEqual<T>(T expected, T actual, IEqualityComparer<T> comparer)

```csharp
Assert.NotStrictEqual<T>(T expected, T actual)
```