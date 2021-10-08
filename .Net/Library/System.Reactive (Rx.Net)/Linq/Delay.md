# Delay

-   非阻塞式
-   將傳入的 IObservable 延遲指定時間後，再執行
    -   注意：不是執行每個 element 都有 Delay 的效果 !

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
