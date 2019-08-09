# InlineData

與 NUnit TestCase 類似的功能

```csharp
public class Tests
{
    [Theory]
    [InlineData(1,2)]
    [InlineData(2,3)]
    public void Test1(int input, int expected)
    {
        var actual = input + 1;
        Assert.Equal(expected, actual);
    }
}
```
