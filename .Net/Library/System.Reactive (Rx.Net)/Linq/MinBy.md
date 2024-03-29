# MinBy

- 阻塞式
- 可視為 GroupBy() 但 key 值取最小的

```cs
var source = Observable.Range(1, 10)
                       .MinBy(x => x % 2 == 0)
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
Subscribe Message:1
Subscribe Message:3
Subscribe Message:5
Subscribe Message:7
Subscribe Message:9
Complete
All Completed !
```