# [isRock.Framework.AOP](https://www.nuget.org/packages/isRock.Framework.AOP)

- 處理 AOP 的對象 class 必須是實作 interface，而且是 interface 的方法才會被 AOP 處理

### 語法

```cs
ITaskProcessor Task = PolicyInjection.Create<ITaskProcessor>(new TaskProcessor());
Task.Run();

interface ITaskProcessor {
    void Run();
}

class TaskProcessor : ITaskProcessor {
    [Log(FileName = "log.txt")]
    public void Run() {
        Console.WriteLine("Run");
    }
}

// AOP 處理
class Log : PolicyInjectionAttributeBase
{
    public string FileName { get; set; }

    public override void BeforeInvoke(object sender, PolicyInjectionAttributeEventArgs e)
    {
        var msg = $"{DateTime.Now} {((MethodInfo)sender).Name} BeforeInvoke";
        SaveLog(msg);
    }

    public override void OnException(object sender, PolicyInjectionAttributeEventArgs e)
    {
        var msg = $"{DateTime.Now} {((MethodInfo)sender).Name} OnException";
        SaveLog(msg);
    }

    public override void AfterInvoke(object sender, PolicyInjectionAttributeEventArgs e)
    {
        var msg = $"{DateTime.Now} {((MethodInfo)sender).Name} AfterInvoke";
        SaveLog(msg);
    }

    private void SaveLog(string msg)
    {
        using (var sw = new StreamWriter(FileName, true))
        {
            sw.WriteLine(msg);
        }
    }
}
```
