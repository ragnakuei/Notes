# Buffer

- 可以做到 Chunk 的結果 !

#### Buffer(count)
- 將執行的 IObservable\<T> 步驟以數量 N 來打包成 IObservable<IList\<T>>

```cs
var source = Observable.Range(1, 10)
                       .Buffer(2)
                       .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s.Select(s => s.ToString()).Join("-")}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
}
```


#### Buffer(count, skip)

count - 每次取的筆數
skip - 每次位移的筆數

```cs
var observer = Observer.Create<IList<int>>(s => Console.WriteLine($"ints:{s.Select(s => s.ToString()).Join(",")}"),
                                                    () => Console.WriteLine("Complete"));

var source = Observable.Range(1, 10)
                       .Buffer(2, 1);

using (source.Subscribe(observer))
{
    Console.WriteLine("All Completed !");
}
```

上述執行後，會是
```
1,2
2,3
...
9,10
10
```
這樣的順序


#### Buffer(TimeSpan, Count)

設定二個逾時條件

- TimeSpan - 時間差
- Count - 數量

其中一個條件滿足後，就會先執行 onNext 的動作


```cs
var source = Observable.Interval(TimeSpan.FromMilliseconds(500))
                        .Take(3)
                        .Concat(Observable.Interval(TimeSpan.FromSeconds(0.1)).Take(30))
                        .Finally(() => Console.WriteLine("All Completed !"))
                        .Buffer(TimeSpan.FromMilliseconds(1000), 5);

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s.Select(i => i.ToString()).Join("-")}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
    source.Wait();
}
```

執行結果

```

```