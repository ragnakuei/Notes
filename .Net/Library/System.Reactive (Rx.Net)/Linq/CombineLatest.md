# CombineLatest

- 阻塞式
- 結合二個不同時間軸的 IObservable\<T>，其中一個 IObservable\<T> 被觸發時，會與另一個 IObservable\<T> 當下時間軸最後一個做 merge


```cs
var source = Observable.CombineLatest(Observable.Range(1, 3),
                                        Observable.Range(4, 3),
                                        (x,y) => $"x:{x} y:{y}")
                        .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
    // source.Wait();
}
```
