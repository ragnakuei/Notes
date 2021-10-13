# ToArray

- 直接轉成阻塞式
- 把 **IObservable\<T>** 轉成 **IObservable\<T[]>**

```cs
var source = Observable.Timer(TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1))
                        .Take(5);

var ol = source.ToArray();

using (ol.Subscribe(onNext: s => s.ForEach(i => Console.WriteLine($"Subscribe Message:{i}")),
                    onError: e => Console.WriteLine(e.Message),
                    onCompleted: () => Console.WriteLine("Complete")))
{
    ol.Wait();
}
```