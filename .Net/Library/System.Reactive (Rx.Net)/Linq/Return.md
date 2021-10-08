# Start

```cs
var source = Observable.Return("a");

using var dispose = source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                        onError: e => Console.WriteLine(e.Message),
                                        onCompleted: () => Console.WriteLine("Complete"));

Console.WriteLine("All Completed !");
```