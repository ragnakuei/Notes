# Equal

比較 expected 與 actual 是否相等。浮點數可傳入精準度。

```csharp
Assert.Equal<T>(T expected, T actual)
Assert.Equal<T>(T expected, T actual, IEqualityComparer<T> comparer)
Assert.Equal(double expected, double actual, int precision)
Assert.Equal(decimal expected, decimal actual, int precision)
Assert.Equal(string expected, string actual)
Assert.Equal(string expected, string actual, bool ignoreCase = false, bool ignoreLineEndingDifferences = false, bool ignoreWhiteSpaceDifferences = false)

```

## StrictEqual

以 EqualityComparer<T>.Default 呼叫 Assert.Equal<T>(T expected, T actual, IEqualityComparer<T> comparer)

```csharp
Assert.StrictEqual<T>(T expected, T actual)
```

## Assert.NotEqual

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