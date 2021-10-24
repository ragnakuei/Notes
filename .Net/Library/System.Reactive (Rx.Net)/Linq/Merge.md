# Merge

- 視傳入的 IObservable\<T> 來決定是否為阻塞式
- 如果傳入的都是**非阻塞式**的 IObservable\<T>，則可以透過**Wait()**來等待，但是會變成強制執行二次 **Finally()**

```cs
var source = Observable.Merge(
                                Observable.Range(1, 3).Delay(TimeSpan.FromMilliseconds(1)),
                                Observable.Range(6, 3)
                            )
                        .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
    // source.Wait();
}
```