# Anonymous Type

匿名型別

可透過反射產生另一個實體

```csharp
void Main()
{
    var a = new {
        Id = 1,
        Name = "A"
    };
    Test(a);

}

public void Test<T>(T _)
{
    _.Dump();
    Activator.CreateInstance(typeof(T), 3, "A").Dump();
}
```