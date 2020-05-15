# [Deconstruction](https://docs.microsoft.com/zh-tw/archive/blogs/msdntaiwan/c7-new-features#desconstruction-)

定義物件如何 "拆解" 為多個獨立的變數。

> 拆解後原物件仍然存在。

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
