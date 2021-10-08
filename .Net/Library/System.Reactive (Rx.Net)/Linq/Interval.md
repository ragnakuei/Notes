# Interval

-   阻塞式
-   等於是 Timer dueTime 為 0 + period !

```cs
class Program
{
    static void Main(string[] args)
    {
        var observer = Observer.Create<Dto<int>>(s => SubscribeAction(s),
                                                    () => Console.WriteLine("Complete"));

        var source = Observable.Interval(TimeSpan.FromSeconds(1))
                                .Select(i => new Dto<int>
                                            {
                                                Date = DateTime.Now
                                            });

        using (source.Subscribe(observer))
        {
            Thread.Sleep(10000);
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
