# Interval

-   阻塞式
-   等於是 Timer dueTime 為 0 + period !

```cs
var source = Observable.Interval(TimeSpan.FromSeconds(1))
                       .Select(i => DateTime.Now)
                       .Take(10)
                       .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s:yyyy/MM/dd hh:mm:ss fffffff}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
    source.Wait();
}
```
