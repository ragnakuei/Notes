# Log Exception

預設的 layout 為 `${exception:format=tostring}`
就是以 Exception.ToString() 的方式輸出

因為既有的 Exception.ToString() 無法以自定義的方式輸出
如果需要自訂輸出格式，可以使用以下方式

### 方式一：繼承既有的 Exception 再 override ToString()

```csharp
public class CustomException : Exception
{
    public CustomException(string message)
        : base(message)
    {
    }

    public CustomException(string message, Exception innerException)
        : base(message, innerException)
    {
    }

    public override string ToString()
    {
        return this.ToFullString();
    }
}

public static class ExceptionExtensions
{
    // 由最內層的 Exception 開始往外層記錄
    public static string ToFullString(this Exception exception, int level = 0)
    {
        var stringBuilder = new StringBuilder();

        if (exception.InnerException != null)
        {
            stringBuilder.AppendLine(exception.InnerException.ToFullString(level + 1));
        }

        stringBuilder.AppendLine(@$"Exception {level} {exception.GetType().FullName}
Message: {exception.Message}
StackTrace: {exception.StackTrace}");

        return stringBuilder.ToString();
    }
}
```

拋出方式

注意：
最外層的 Exception 要用 throw new CustomException()，不能用 throw
才能讓底層處理 Exception.ToString() 可以吃到 CustomException.ToString()


```cs
try
{
    try
    {
        throw new Exception("GetException1");
    }
    catch (Exception e)
    {
        throw new Exception("GetException2", e);
    }
}
catch (Exception e)
{
    throw new CustomException("GetException3", e);
}
```
