# ToEvent

- 將 **IObservable\<T>** 轉為 **IEventSource\<T>**
- 非阻塞式
- Callback 透過 .OnNext() 執行 !

```cs
var source = Observable.Timer(TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1))
                        .Take(5)
                        .Finally(() => Console.WriteLine("All Completed !"));

var eventSource = source.ToEvent();

eventSource.OnNext += i => Console.WriteLine($"Subscribe Message:{i}");

source.Wait();
```