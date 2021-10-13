# MaxBy

- 阻塞式
- 可視為 GroupBy() 但 key 值取最小的

```cs
var source = Observable.Range(1, 10)
                       .MaxBy(x => x % 2 == 0)
                       .Finally(() => Console.WriteLine("All Completed !"));

using var dispose = source.Subscribe(onNext: s =>
                                                {
                                                    foreach (var i in s)
                                                    {
                                                        Console.WriteLine($"Subscribe Message:{i}");
                                                    }
                                                },
                                        onError: e => Console.WriteLine(e.Message),
                                        onCompleted: () => Console.WriteLine("Complete"));
```

執行結果：

```
Subscribe Message:2
Subscribe Message:4
Subscribe Message:6
Subscribe Message:8
Subscribe Message:10
Complete
All Completed !
```