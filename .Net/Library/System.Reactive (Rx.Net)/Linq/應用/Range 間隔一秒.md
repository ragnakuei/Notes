# Range 間隔一秒

```cs
var source = Observable.Range(1, 10)
                        .Select(i =>
                                {
                                    Thread.Sleep(1000);
                                    return i;
                                });
using var dispose = source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                        onError: e => Console.WriteLine(e.Message),
                                        onCompleted: () => Console.WriteLine("Complete"));

Console.WriteLine("All Completed !");
```