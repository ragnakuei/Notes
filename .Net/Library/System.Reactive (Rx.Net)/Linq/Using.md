# Using

- 阻塞式
- 將需要進行 Dispose 的資源以 Using 包裝

```cs
private static void Sample02()
{
    var source = Observable.Using(() => new TestDto { Id = 1 },
                                  testDto => Observable.Return(testDto))
                            .Finally(() => Console.WriteLine("All Completed !"));

    using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s.Id}"),
                            onError: e => Console.WriteLine(e.Message),
                            onCompleted: () => Console.WriteLine("Complete")))
    {
    }
}

public class TestDto : IDisposable
{
    public int Id { get; set; }

    public void Dispose()
    {
        Console.WriteLine($"{nameof(TestDto)} is Dispose");
    }
}
```

執行結果：

```
Subscribe Message:1
Complete
TestDto is Dispose
All Completed !
```