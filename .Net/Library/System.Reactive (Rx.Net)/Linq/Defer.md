# Defer

延遲產生 Observable

#### 範例一

以下的輸出時間，都是相同的

```cs
var observer = Observer.Create<DateTime>(s => Console.WriteLine(s.ToString("hh:mm:ss fffffff")),
                                            () => Console.WriteLine("Complete"));
// 這行會有差
var source = Observable.Return(DateTime.Now)
                        .Repeat(5)
                        .Take(4);

using (source.Subscribe(observer))
{
    Console.WriteLine("All Completed !");
}
```

以下的輸出時間，都是不同的

```cs
var observer = Observer.Create<DateTime>(s => Console.WriteLine(s.ToString("hh:mm:ss fffffff")),
                                            () => Console.WriteLine("Complete"));

// 這行改為以 Defer 包裝
var source = Observable.Defer(() => Observable.Return(DateTime.Now))
                        .Repeat(5)
                        .Take(4);

using (source.Subscribe(observer))
{
    Console.WriteLine("All Completed !");
}
```