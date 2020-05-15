# iterator 取出所有 enum 的元素

```csharp
void Main()
{
    Enum.GetValues(typeof(Test))
        .Cast<Test>().Dump();

    Enum.GetValues(typeof(Test))
        .Cast<Test>()                // 不需要加 Select
        .ToDictionary(e => e, e => (int)e)
        .Dump();
}

public enum Test
{
    A = 1,
    B = 2,
    C = 3,
    D = 4,
}
```
