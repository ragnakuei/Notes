# FromAsync

- 非阻塞式
- 將非同步轉成 Observable\<T>

```cs
private static void Sample02()
{
    var source = Observable.FromAsync(() => AsyncTask());

    using var dispose = source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                            onError: e => Console.WriteLine(e.Message),
                                            onCompleted: () => Console.WriteLine("Complete"));

    source.Wait();

    Console.WriteLine("All Completed !");
}

private static async Task<int> AsyncTask()
{
    await Task.Delay(500);

    return 1;
}
```
