# ToEnumerable

- 直接轉成阻塞式
- 把 IObservable\<T> 轉成 IEnumerable\<T>

### 範例

- 如果 **ToEnumerable()** 後面再加上 **ToList()** 會變成看不出 Period 的效果 !

```cs
var source = Observable.Timer(TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1))
                        .Take(5);

IEnumerable<long> e = source.ToEnumerable();

foreach (var i in e)
{
    Console.WriteLine(i);
}

Console.WriteLine("All Completed !");
```