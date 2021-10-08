# 範例二

```cs
using System.Reactive.Subjects;
using System.Reactive.Linq;
using System.Reactive;

void Main()
{
    var observer = Observer.Create<Dto<long>>(s => SubscribeAction(s),
                                             () => "Complete".Dump());

    // 動作：等 2 秒後，每 1 秒 執行 onNext
    var source = Observable.Timer(TimeSpan.FromSeconds(2),
                                  TimeSpan.FromSeconds(1))
                            .Select((t, index) => new Dto<long>
                            {
                                Date = DateTime.Now,
                                Item = t,
                            });
    using (source.Subscribe(observer))
    {
        Thread.Sleep(10000);
        "All Completed !".Dump();
    }
}

public class Dto<T>
{
    public DateTime Date { get; set; }

    public T Item { get; set; }
}

private void SubscribeAction<T>(Dto<T> dto)
{
    dto.Date.ToString("hh:mm:ss fffffff").Dump();
}
```