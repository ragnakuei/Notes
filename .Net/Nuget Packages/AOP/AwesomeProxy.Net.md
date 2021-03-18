# [AwesomeProxy.Net](https://github.com/isdaniel/AwesomeProxy.Net)

[【C#】 AOP輕型框架 AwesomeProxy.Net 介紹使用](https://dotblogs.com.tw/daniel/2018/02/11/111605)

## 範例

### 建立 AOP Class

用來指定 AOP 的動作

注意：發生 Exception 時，原本的 Exception 會在 InnerException 內~

```csharp
public class TestAopAttribute : AopBaseAttribute
{
    public override void OnExecuting(ExecutingContext context)
    {
        var args = context.Args[0].ToString();
        
        Console.WriteLine($"OnExecuting args[0]:{args}");
    }

    public override void OnExecuted(ExecutedContext context)
    {
        var args = context.Args[0].ToString();
        
        Console.WriteLine($"OnExecuted args[0]:{args}");
    }

    public override void OnException(ExceptionContext exceptionContext)
    {
        Console.WriteLine($"OnException InnerException Message:{exceptionContext?.Exception?.InnerException?.Message}");
    }
}
```

### 套用 AOP Method 的 Class，必須繼承 MarshalByRefObject


```csharp
public class Test : MarshalByRefObject
{
    [TestAop]
    public void Start(string arg)
    {
        Console.WriteLine($"Start arg:{arg}");
    }

    [TestAop]
    public void Exception(string arg)
    {
        throw new Exception("Test Exception");
    }
}
```

### 要透過 ProxyFactory.GetProxyInstance<T>() 來產生上述的 Class

```csharp
internal class Program
{
    public static void Main(string[] args)
    {
        var arg = "TestArgs";
        
        var t = ProxyFactory.GetProxyInstance<Test>();
        t.Start(arg);
        t.Exception(arg);
    }
}
```