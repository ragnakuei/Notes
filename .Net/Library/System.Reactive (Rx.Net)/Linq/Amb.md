# Amb

- 阻塞式
- 傳入多個 IObservable\<T>，只會完整執行先執行的那個 IObservable\<T>，其餘則忽略

#### 範例

- 如果 Delay() 拿掉，則會先跑 1 > 2 > 3

```cs
var source = Observable.Amb(
                            Observable.Range(1, 3).Delay(TimeSpan.FromMilliseconds(1)),
                            Observable.Range(6, 3)
                            )
                        .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
}
```