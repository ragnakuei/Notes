# FromAsync

將非同步轉成 Observable\<T>

```cs
class Program
{
    static void Main(string[] args)
    {
        var observer = Observer.Create<Dto<long>>(s => SubscribeAction(s),
                                                  () => Console.WriteLine("Complete"));

        var source = Observable.FromAsync(() => Task.FromResult(new Dto<long>()));

        using (source.Subscribe(observer))
        {
            Console.WriteLine("All Completed !");
        }
    }

    private static void SubscribeAction<T>(Dto<T> dto)
    {
        Console.WriteLine(dto.Date.ToString("hh:mm:ss fffffff"));
    }
}

public class Dto<T>
{
    public DateTime Date { get; set; }

    public T Item { get; set; }
}
```
