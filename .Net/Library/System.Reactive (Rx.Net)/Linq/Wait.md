# Wait

- 用在 Timer 上，會持續等待
- 用在 Delay 上，會等 Delay 完成
  - 但原本的工作可能未完成

```cs
var source = Observable.Timer(TimeSpan.FromSeconds(2),
                              TimeSpan.FromSeconds(1));

using var dispose = source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                     onError: e => Console.WriteLine(e.Message),
                                     onCompleted: () => Console.WriteLine("Complete"));

source.Wait();

Console.WriteLine("All Completed !");
```
