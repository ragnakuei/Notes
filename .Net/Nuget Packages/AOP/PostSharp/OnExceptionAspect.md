# [OnExceptionAspect](https://doc.postsharp.net/t_postsharp_aspects_onexceptionaspect)

---

## 範例

```csharp
[Serializable]
public class ExceptionAttribute : OnExceptionAspect
{
    /// <summary>
    /// 產生 Exception 時
    /// </summary>
    public override void OnException(MethodExecutionArgs args)
    {
        base.OnException(args);
        
        Console.WriteLine("OnException");

        if (args.Exception != null)
        {
            Console.WriteLine($"Exception Message:{args.Exception.Message}");
        }
    }
}

```

### 套用至需要的地方

```csharp
public static void Main(string[] args)
{
    var arg = "tmall";
    Console.WriteLine($"original argument:{arg}");
    StartException(arg);
}

[Exception]
private static void StartException(string arg)
{
    Console.WriteLine($"StartException argument:{arg}");
    throw new Exception("Test");
    Console.WriteLine("StartException finished");
}
```
