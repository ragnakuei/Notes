# [Pattern Matching](https://blogs.msdn.microsoft.com/msdntaiwan/2017/04/10/c7-new-features/#pattern-matching-)

## 三種模式

1. Constant Patterns 常數模式
1. Type Patterns 類型模式
1. Var Patterns 變數模式

## 二種增強語法

1. is
1. switch case

能轉成該型別時，就會是比對成功。 Var 會是編譯時期給定的型別，所以適用性最高。

### is

```csharp
void Main()
{
    var objs = new dynamic[]{
        0,
        "1",
        (decimal?)2m,
        (decimal?)null
    };

    foreach (var obj in objs)
    {
        Test(obj);
    }
}

private void Test(dynamic obj)
{
    if(obj is string s)
    {
        $"string:{s}".Dump();
    }
    else if(obj is int i)  // Type Patterns
    {
        $"int:{i}".Dump(); 
    }
    else if (obj is null)   // Constant Patterns
    {
        $"null".Dump();
    }
    else if (obj is var v)  // Var Patterns
    {
        $"var:{v}".Dump();
    }
}
```

### switch case

```csharp
void Main()
{
    var objs = new dynamic[]{
        0,
        "1",
        (decimal?)2m,
        (decimal?)null
    };

    foreach (var obj in objs)
    {
        Test(obj);
    }
}

private void Test(dynamic obj)
{
    switch (obj)
    {
        case string s:
            $"string:{s}".Dump();
            break;
        case int i when (i % 2 == 0):
            $"int:{i}".Dump();
            break;
        case null:
            $"null".Dump();
            break;
        case var v:
            $"var:{v}".Dump();
            break;
    }
}
```

default 的語法順序不一定要放最後面，但仍是最後判斷

```csharp
void Main()
{
    var objs = new dynamic[]{
        0,
        "1",
        (decimal?)2m,
        (decimal?)null
    };

    foreach (var obj in objs)
    {
        Test(obj);
    }
}

private void Test(dynamic obj)
{
    switch (obj)
    {
        default:
            "object:{obj}".Dump();
            break;
        case string s:
            $"string:{s}".Dump();
            break;
        case int i when (i % 2 == 0):
            $"int:{i}".Dump();
            break;
        case null:
            $"null".Dump();
            break;
//        case var v:
//            $"var:{v}".Dump();
//            break;
    }
}

```