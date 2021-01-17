# [MrAdvice](https://github.com/ArxOne/MrAdvice)

語法極簡的 AOP 套件


## 範例

### 範例一

```csharp
class Program
{
    static void Main(string[] args)
    {
        var t = new Test();
        t.TestMethod(1, "a");
    }
}

public class Test
{
    public Test()
    {
    }

    [MyProudAdvice]
    public void TestMethod(int v1, string v2)
    {

    }
}

public class MyProudAdvice : Attribute, IMethodAdvice
{
    public void Advise(MethodAdviceContext context)
    {
        Console.WriteLine($"before call method args[0]:{context.Arguments[0]}");

        context.Proceed();

        Console.WriteLine("after call method");
    }
}
```
