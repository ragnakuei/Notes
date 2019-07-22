# [ValueTuple Struct](https://docs.microsoft.com/zh-tw/dotnet/api/system.valuetuple?view=netframework-4.8)

- 可給定 具名 Property
- Value Type


## 不具名用法

大致上跟 Tuple 使用方式一樣，但 Tuple 是 Reference Type，而 Value Tuple 是 Value Type

```csharp
void Main()
{
    var t1 = (1, "A");
    t1.Dump();
    // t1.Id.Dump();
    t1.Item1.Dump();
    // t1.Name.Dump();
    t1.Item2.Dump();
    
    Test1(t1);
}

private void Test1((int, string ) t)
{
    t.Item1 = 0;
    t.Item2 = string.Empty;
}
```


## 具名用法
```csharp
void Main()
{
    var t2 = (Id : 2, Name : "B");
    t2.Dump();
    t2.Id.Dump();
    t2.Item1.Dump();
    t2.Name.Dump();
    t2.Item2.Dump();
    
    Test1(t2);
    t2.Dump();
}

private void Test2((int id, string name) t)
{
    t.Item1 = 0;
    t.id= 0;
    t.Item2 = string.Empty;
    t.name= string.Empty;
}
```