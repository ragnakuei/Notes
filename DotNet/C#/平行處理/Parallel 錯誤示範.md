# Parallel 錯誤示範

Parallel 要用在適合的地方 !

```csharp
void Main()
{
    var tests1 = Enumerable.Range(1, 1000).Select(i => new Test { Id = i });
    var tests2 = Enumerable.Range(1, 1000);

// 大約 6 秒
//    Parallel.ForEach(tests1, t1 =>
//    {
//        t1.UpperId = tests2.AsParallel().FirstOrDefault(t2 => t2 < t1.Id);
//    });

// 不到 0.02 秒
    foreach (var t1 in tests1)
    {
        t1.UpperId = tests2.AsParallel().FirstOrDefault(t2 => t2 < t1.Id);
    };
}

public class Test
{
    public int Id { get; set; }
    public int UpperId { get; set; }
}
```
