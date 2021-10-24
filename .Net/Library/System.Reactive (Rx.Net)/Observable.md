# Observable


##### Subscribe 套用 CancellationToken

```cs
var cts = new CancellationTokenSource();

var source = Observable.Interval(TimeSpan.FromMilliseconds(200));

source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                 onError: e => Console.WriteLine(e.Message),
                 onCompleted: () => Console.WriteLine("Complete"),
                 cts.Token);

Thread.Sleep(5000);
cts.Cancel();

Console.WriteLine("Completed");
```