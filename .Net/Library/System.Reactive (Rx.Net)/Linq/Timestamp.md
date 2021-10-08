# Timestamp

- 會轉成 Timestamped\<T>
  - 包含 Property
    - Timestamp : DateTimeOffset - UTC + 0 的執行時間
    - Value : T

```cs
static void Main(string[] args)
{
    var observer = Observer.Create<Timestamped<int>>(s => Console.WriteLine(s.Timestamp.ToString("hh:mm:ss fffffff")),
                                                        () => Console.WriteLine("Complete"));

    var source = Observable.Range(1, 10)
                            .Timestamp();

    using (source.Subscribe(observer))
    {
        Console.WriteLine("All Completed !");
    }
}
```