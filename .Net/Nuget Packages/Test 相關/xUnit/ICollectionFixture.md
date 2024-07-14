# [ICollectionFixture](https://xunit.net/docs/shared-context#collection-fixture)

讓不同的 Test Class 間，可以共用 instance。以下是修改前：

```csharp
public class TestForAdd : IClassFixture<CalculatorFixture>
{
    private readonly Calculator        _calculator;
    private readonly ITestOutputHelper _output;

    public TestForAdd(ITestOutputHelper output, CalculatorFixture calculatorFixture)
    {
        _calculator = calculatorFixture.Calculator;
        _output     = output;
    }

    [Fact]
    public void Given_1_Add_2_Expected_3()
    {
        _output.WriteLine(_calculator.ThreadId.ToString());
        var actual = _calculator.Add(1, 2);
        Assert.Equal(3, actual);
    }
}

public class TestForSubtract : IClassFixture<CalculatorFixture>
{
    private readonly Calculator        _calculator;
    private readonly ITestOutputHelper _output;

    public TestForSubtract(ITestOutputHelper output, CalculatorFixture calculatorFixture)
    {
        _calculator = calculatorFixture.Calculator;
        _output     = output;
    }

    [Fact]
    public void Given_1_Subtract_2_Expected_Minus1()
    {
        _output.WriteLine(_calculator.ThreadId.ToString());
        var actual = _calculator.Subtract(1, 2);
        Assert.Equal(-1, actual);
    }
}

public class CalculatorFixture : IDisposable
{
    private readonly Calculator _calculator = new Calculator();

    public Calculator Calculator => _calculator;

    public void Dispose()
    {
        // 這邊會呼叫二次
        var id = _calculator.ThreadId;
    }
}

public class Calculator
{
    private int _threadId;
    public  int ThreadId => _threadId;

    public Calculator()
    {
        _threadId = Thread.CurrentThread.ManagedThreadId;
    }

    public int Add(int i1, int i2)
    {
        return i1 + i2;
    }

    public int Subtract(int i1, int i2)
    {
        return i1 - i2;
    }
}
```

修改後：

- 透過 [CollectionDefinition("Test")] 來定義要被共用的 class
- class 必須繼承 ICollectionFixture<T> T 就是被共用的 instance type
- 在要使用共用的 Test Class 上加加上 [Collection("Test")] 就可以注入 T 來達成共用的目的
- 注意 [CollectionDefinition("Test")] 與 [Collection("Test")] 所定義的名稱要一致
- Test Class 不需要繼承 IClassFixture

```csharp
[CollectionDefinition("Test")]
public class CalculatorCollection : ICollectionFixture<CalculatorFixture>
{
}

[Collection("Test")]
public class TestForAdd
{
    private readonly Calculator        _calculator;
    private readonly ITestOutputHelper _output;

    public TestForAdd(ITestOutputHelper output, CalculatorFixture calculatorFixture)
    {
        _calculator = calculatorFixture.Calculator;
        _output     = output;
    }

    [Fact]
    public void Given_1_Add_2_Expected_3()
    {
        _output.WriteLine(_calculator.ThreadId.ToString());
        var actual = _calculator.Add(1, 2);
        Assert.Equal(3, actual);
    }
}

[Collection("Test")]
public class TestForSubtract
{
    private readonly Calculator        _calculator;
    private readonly ITestOutputHelper _output;

    public TestForSubtract(ITestOutputHelper output, CalculatorFixture calculatorFixture)
    {
        _calculator = calculatorFixture.Calculator;
        _output     = output;
    }

    [Fact]
    public void Given_1_Subtract_2_Expected_Minus1()
    {
        _output.WriteLine(_calculator.ThreadId.ToString());
        var actual = _calculator.Subtract(1, 2);
        Assert.Equal(-1, actual);
    }
}
```
