# [IClassFixture](https://xunit.net/docs/shared-context#class-fixture)

讓指定的 instance 在 Test Class 執行完畢時，可以被 Dispose

> 把中斷點下在 `_calculator.ThreadId` 的地方，會發現會 Dispose 一次。

```csharp
public class Tests : IClassFixture<CalculatorFixture>
{
    private readonly Calculator _calculator;

    public Tests(CalculatorFixture calculatorFixture)
    {
        _calculator = calculatorFixture.Calculator;
    }

    [Fact]
    public void Given_1_Add_2_Expected_3()
    {
        var actual = _calculator.Add(1, 2);
        Assert.Equal(3, actual);
    }

    [Fact]
    public void Given_1_Subtract_2_Expected_Minus1()
    {
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
        // 可以用中斷點看此處被呼叫的次數
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
