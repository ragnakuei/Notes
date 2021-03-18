# [Deconstruction](https://docs.microsoft.com/zh-tw/archive/blogs/msdntaiwan/c7-new-features#desconstruction-)

- 定義物件如何 "拆解" 為多個獨立的變數。
- 或稱 `deconstructor`

    - [C# 7 分解式](https://www.huanlintalk.com/2017/04/c-7-deconstruction-syntax.html)

> 拆解後原物件仍然存在。

## 語法： tuple

```csharp
void Main()
{
    int i1 = 0;
    int i2 = 0;

    (i1, i2) = Test();
    i1.Dump();
    i2.Dump();

    var (i3, i4) = Test();
    i3.Dump();
    i4.Dump();

    (var i5, var i6) = Test();
    i5.Dump();
    i6.Dump();
}

private (int i1, int i2) Test()
{
    return (i1 : 1, i2 : 2);
}

```


## 語法： class

```csharp
void Main()
{
    var p = new Person { FirstName = "A", LastName = "B" };
    
    var (firstName, lastName) = p;
    firstName.Dump();
    lastName.Dump();
}

public class Person
{
    public string FirstName { get; set; }
    
    public string LastName { get; set; }
    
    public void Deconstruct(out string firstName, out string lastName)
    {
        firstName = FirstName;
        lastName = LastName;
    }
}
```