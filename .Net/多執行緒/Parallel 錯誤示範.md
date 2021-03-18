# Parallel 錯誤示範

Parallel 要用在適合的地方 !

```csharp
void Main()
{
    var tests1 = Enumerable.Range(1, 1000).Select(i => new Test { Id = i });
    var tests2 = Enumerable.Range(1, 1000);

// 六核的電腦，大約要 6 秒，但 12 核的電腦就大約只要 0.3 秒，多次執行偶爾會有 Delay 的情況
//    Parallel.ForEach(tests1, t1 =>
//    {
//        t1.UpperId = tests2.AsParallel().FirstOrDefault(t2 => t2 < t1.Id);
//    });

// 六核的電腦，不到 0.02 秒，但 12 核的電腦就大約要 0.5 秒，多次執行相對穩定。
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
