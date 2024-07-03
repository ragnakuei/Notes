# Exception

泛型所回傳的是指定的 Exception Type，非泛型都回傳 Exception。

## 驗証 Exception Message

如果需要驗証 Exception Message 可以利用回傳值來驗証。

```csharp
var actual = Assert.Throws<Exception>(() => ThrowException());
Assert.Equal("Test", actual.Message);
```

## Assert.Throws

```csharp
Assert.Throws<T>(Action testCode) where T : Exception
// Assert.Throws<T>(Func<Task> testCode) where T : Exception
Assert.Throws<T>(Func<object> testCode) where T : Exception
Assert.Throws(Type exceptionType, Action testCode)
Assert.Throws(Type exceptionType, Func<object> testCode)
Assert.Throws(Type exceptionType, Exception exception)
Assert.Throws<T>(string paramName, Action testCode) where T : ArgumentException
Assert.Throws<T>(string paramName, Func<object> testCode) where T : ArgumentException
// Assert.Throws<T>(string paramName, Func<Task> testCode) where T : ArgumentException
```

## Assert.ThrowsAsync

```csharp
Assert.ThrowsAsync<T>(Func<Task> testCode) where T : Exception
Assert.ThrowsAsync(Type exceptionType, Func<Task> testCode)
```

## Assert.ThrowsAny

```csharp
Assert.ThrowsAny<T>(Action testCode) where T : Exception
Assert.ThrowsAny<T>(Func<object> testCode) where T : Exception
Assert.ThrowsAny(Type exceptionType, Exception exception)
Assert.ThrowsAsync<T>(string paramName, Func<Task> testCode) where T : ArgumentException
```

## Assert.ThrowsAnyAsync

```csharp
Assert.ThrowsAnyAsync<T>(Func<Task> testCode) where T : Exception
Assert.
```
