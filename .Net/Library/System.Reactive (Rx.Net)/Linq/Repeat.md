# Repeat

- 將 Observable 重複執行
- 如果以 Observable.Repeat(N) 建立 Observable 時，就會視為無限迴圈 !
  - 可直接加 .Take(N) 來限制幾次 !

```cs
var source = Observable.Return(DateTime.Now)
                        .Repeat(5)
                        .Take(4)
                        .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s:yyyy/MM/dd hh:mm:ss fffffff}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
    
}
```