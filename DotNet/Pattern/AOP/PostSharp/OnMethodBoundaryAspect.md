# [OnMethodBoundaryAspect](https://doc.postsharp.net/t_postsharp_aspects_onmethodboundaryaspect)

## 範例

### 建立繼承 OnMethodBoundaryAspect 的類別

```csharp
[Serializable]
public class MethodAttribute : OnMethodBoundaryAspect
{
    /// <summary>
    /// 方法進入時
    /// </summary>
    public override void OnEntry(MethodExecutionArgs args)
    {
        Console.WriteLine("OnEntry");
        
        //修改輸入參數
        args.Arguments[0] = "jingdong";

        //設置方法是否繼續執行或退出，若設置的是FlowBehavior.Return方法會直接退出，不執行後續的所有代碼。
        args.FlowBehavior = FlowBehavior.Continue;
    }

    public override void OnResume(MethodExecutionArgs args)
    {
        Console.WriteLine("OnResume");
    }

    public override void OnYield(MethodExecutionArgs args)
    {
        Console.WriteLine("OnYield");
    }

    /// <summary>
    /// 方法成功執行時
    /// </summary>
    public override void OnSuccess(MethodExecutionArgs args)
    {
        Console.WriteLine("OnSuccess");
    }

    /// <summary>
    /// 方法離開時
    /// </summary>
    public override void OnExit(MethodExecutionArgs args)
    {
        Console.WriteLine("OnExit");
    }
}
```

### 套用至需要的地方

`[Method]` 會尋找 `MethodAttribute` 來執行

```csharp
public static void Main(string[] args)
{
    var arg = "tmall";
    Console.WriteLine($"original argument:{arg}");
    Start(ref arg);
}

[Method]
private static void Start(ref string arg)
{
    Console.WriteLine($"Start argument:{arg}");
    Thread.Sleep(1000);
    Console.WriteLine("Start finished");
}
```
