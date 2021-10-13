# StartWith

- 阻塞式
- 在原本的 IObservable\<T> 加上會先執行的 T[]，再來執行原本給的 IObservable\<T>

```cs
var source = Observable.Range(1, 3)
                        .StartWith(-1, 0)
                        .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
}
```