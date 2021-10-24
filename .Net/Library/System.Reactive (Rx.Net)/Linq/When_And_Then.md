# When_And_Then.md

- 阻塞式
- 可用來串接不同時間產生的資料，但只會跑相同的數量

```cs
var one   = Observable.Interval(TimeSpan.FromMilliseconds(600)).Take(3);
var two   = Observable.Interval(TimeSpan.FromMilliseconds(300)).Take(6);
var three = Observable.Interval(TimeSpan.FromMilliseconds(200)).Take(9);

var source = Observable.When(
                                one.And(two).And(three).Then((t1, t2, t3) => $"one:{t1} two:{t2} three:{t3}")
                            )
                        .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
    source.Wait();
}
```

執行結果

```
Subscribe Message:one:0 two:0 three:0
Subscribe Message:one:1 two:1 three:1
Subscribe Message:one:2 two:2 three:2
Complete
All Completed !
All Completed !
```