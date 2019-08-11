# String

有些字串比對的 method 可以給定參數 StringComparison


不給定 StringComparison，就會以 以 StringComparison.CurrentCulture 進行比對

## Assert.Equal

比對字串是否相等

- **ignoreCase** - 不區分大小寫
- **ignoreLineEndingDifferences** - 忽略 \r 或 \n 換行字元
- **ignoreWhiteSpaceDifferences** - 忽略 空白 及 tab 間隔

```csharp
Assert.Equal(string expected, string actual)
Assert.Equal(string expected, string actual, bool ignoreCase = false, bool ignoreLineEndingDifferences = false, bool ignoreWhiteSpaceDifferences = false)
```

## Assert.StartsWith

判斷 actualString 是否以 expectedStartString 做為字串開頭

```csharp
Assert.StartsWith(string expectedStartString , string  actualString)
Assert.StartsWith(string expectedStartString , string  actualString , StringComparison comparisonType)
```

## Assert.EndsWith

判斷 actualString 是否以 expectedEndString 做為字串結尾

```csharp
Assert.EndsWith(string expectedStartString , string  actualString)
Assert.EndsWith(string expectedStartString , string  actualString , StringComparison comparisonType)
```

## Assert.Contains

判斷 actualString 是否包含 expectedSubstring

```csharp
Assert.Contains(string expectedStartString , string  actualString)
Assert.Contains(string expectedStartString , string  actualString , StringComparison comparisonType)
```

## Assert.DoesNotContain

判斷 actualString 是否不包含 expectedSubstring

```csharp
Assert.DoesNotContain(string expectedStartString , string  actualString)
Assert.DoesNotContain(string expectedStartString , string  actualString , StringComparison comparisonType)
```

## Assert.Matches

以正規法判斷字串是否符合條件

```csharp
Assert.Matches(string expectedRegexPattern, string actualString)
Assert.Matches(Regex expectedRegex, string actualString)
```

## Assert.DoesNotMatch

以正規法判斷字串是否不符合條件

```csharp
Assert.DoesNotMatch(string expectedRegexPattern, string actualString)
Assert.DoesNotMatch(Regex expectedRegex, string actualString)
```
