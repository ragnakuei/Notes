# Except 不同 Class 的方式

[Compare Test Sample](ComparSample/ComparaerDifferentClass)

```csharp
void Main()
{
    var t1s = new List<Test1> {
        new Test1{ Id = 1, Name = "A" },
        new Test1{ Id = 2, Name = "B" },
        new Test1{ Id = 3, Name = "C" }
    };
    var t2s = new List<Test2> {
        new Test2{ Id = 2, Name = "B" },
        new Test2{ Id = 3, Name = "C" }
    };

    t1s.Where(t1 => t2s.Any(t2 => t2.Id == t1.Id) == false).Dump();

    // 效能差一些
    Test1ExceptTest2(t1s, t2s, (t1, t2) => t1.Id == t2.Id).Dump();
}

private IEnumerable<Test1> Test1ExceptTest2<Test1, Test2>(List<Test1> t1s, List<Test2> t2s, Func<Test1, Test2, bool> comparer)
{
    foreach (var t1 in t1s)
    {
        if (t2s.Any(t2 => comparer(t1, t2)) == false)
        {
            yield return t1;
        }
    }
}

public class Test1
{
    public int Id { get; set; }
    public string Name { get; set; }
}

public class Test2
{
    public int Id { get; set; }
    public string Name { get; set; }
}
```
