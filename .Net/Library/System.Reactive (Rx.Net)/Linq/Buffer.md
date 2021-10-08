# Buffer

- 可以做到 Chunk 的結果 !

#### Buffer(count)
- 將執行的 IObservable\<T> 步驟以數量 N 來打包成 IObservable<IList\<T>>

```cs
var observer = Observer.Create<IList<int>>(s => Console.WriteLine($"ints:{s.Select(s => s.ToString()).Join(",")}"),
                                          () => Console.WriteLine("Complete"));

var source = Observable.Range(1, 10)
                        .Buffer(2);

using (source.Subscribe(observer))
{
    Console.WriteLine("All Completed !");
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

