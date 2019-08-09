# String

字串比對都可以給定參數 StringComparison

不給定 StringComparison，就會以 以 StringComparison.CurrentCulture 進行比對

## Assert.StartsWith

判斷 actualString 是否以 expectedStartString 做為字串開頭

Overloads

- Assert.StartsWith(string expectedStartString , string  actualString)
- Assert.StartsWith(string expectedStartString , string  actualString , StringComparison comparisonType)

## Assert.EndsWith

判斷 actualString 是否以 expectedEndString 做為字串結尾

Overloads

- Assert.EndsWith(string expectedStartString , string  actualString)
- Assert.EndsWith(string expectedStartString , string  actualString , StringComparison comparisonType)

## Assert.Contains

判斷 actualString 是否包含 expectedSubstring

Overloads

- Assert.Contains(string expectedStartString , string  actualString)
- Assert.Contains(string expectedStartString , string  actualString , StringComparison comparisonType)

## Assert.DoesNotContain

判斷 actualString 是否不包含 expectedSubstring

Overloads

- Assert.DoesNotContain(string expectedStartString , string  actualString)
- Assert.DoesNotContain(string expectedStartString , string  actualString , StringComparison comparisonType)
