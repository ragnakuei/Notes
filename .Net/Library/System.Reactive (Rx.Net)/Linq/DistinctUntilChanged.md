# DistinctUntilChanged

- 阻塞式
- iterator 每個 element，當 element 改變時才會進行 onNext()

```cs
var source = new[] { 1, 1, 2, 2, 3, 1, 1, 3 }.ToObservable()
                                             .DistinctUntilChanged();

using var dispose = source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                        onError: e => Console.WriteLine(e.Message),
                                        onCompleted: () => Console.WriteLine("Complete"));

Console.WriteLine("All Completed !");
```

執行結果：

```
Subscribe Message:1
Subscribe Message:2
Subscribe Message:3
Subscribe Message:1
Subscribe Message:3
Complete
All Completed !
```
