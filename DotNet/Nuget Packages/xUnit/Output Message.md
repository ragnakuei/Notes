# [Output](https://xunit.net/docs/capturing-output) Message

要輸出訊息要 DI ITestOutputHelper 再以 WriteLine() 就可以輸出訊息了。

> 使用 Debug.WriteLine 或 Console.WriteLine 都無法輸出訊息。

```csharp
public class Tests : IClassFixture<Calculator>
{
    private readonly Calculator _calculator;
    private readonly ITestOutputHelper _output;

    public Tests(Calculator calculator, ITestOutputHelper output)
    {
        _calculator = calculator;
        _output = output;
    }

    [Fact]
    public void Given_1_Add_2_Expected_3()
    {
        _output.WriteLine(_calculator.ThreadId.ToString());
        var actual = _calculator.Add(1, 2);
        Assert.Equal(3, actual);
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