# ToTask

- 可以用來等待所有工作都完成 !

#### 範例

```cs
var source = Observable.Range(1, 10)
                       .Delay(TimeSpan.FromSeconds(1));
using var dispose = source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                     onError: e => Console.WriteLine(e.Message),
                                     onCompleted: () => Console.WriteLine("Complete"));

var task = source.ToTask();
while (task.IsCompleted == false)
{
    Thread.Sleep(1);
}

Console.WriteLine("All Completed !");
```