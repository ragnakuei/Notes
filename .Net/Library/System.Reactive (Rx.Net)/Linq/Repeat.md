# Repeat

- 將 Observable 重複執行
- 如果以 Observable.Repeat(N) 建立 Observable 時，就會視為無限迴圈 !
  - 可直接加 .Take(N) 來限制幾次 !

```cs
var observer = Observer.Create<DateTime>(s => Console.WriteLine(s.ToString("hh:mm:ss fffffff")),
                                            () => Console.WriteLine("Complete"));

var source = Observable.Return(DateTime.Now)
                       .Repeat(5)
                       .Take(4);

using (source.Subscribe(observer))
{
    Console.WriteLine("All Completed !");
}
```