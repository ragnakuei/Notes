

語法
```csharp
public static class CsvHelper
{
    public static string GenerateRow(int maxColumnCount, params string[] columnValues)
    {
        var columns = new string[maxColumnCount];

        for (int i = 0 ; i < maxColumnCount ; i++)
        {
            columns[i] = i < columnValues?.Length
                            ? columnValues[i]?.EscapeDoubleQuotes()
                            : string.Empty;
        }
        
        return "\"" + string.Join("\",\"", columns) + "\"";
    }
    
    private static string EscapeDoubleQuotes(this string value)
    {
        return value.Replace("\"", "\"\"");
    }
}
```

Test Case
```csharp
[TestFixture]
public class GenerateRow_Test
{
    [Test]
    public void OneColumn_NullValues()
    {
        var actual = CsvHelper.GenerateRow(1, null);

        var expected = "\"\"";
        
        Assert.AreEqual(expected, actual);
    }
            
    [Test]
    public void OneColumn_OneValue()
    {
        var actual = CsvHelper.GenerateRow(1, new [] {"1"});

        var expected = "\"1\"";
        
        Assert.AreEqual(expected, actual);
    }

    [Test]
    public void OneColumn_TwoValues()
    {
        var actual = CsvHelper.GenerateRow(1, new [] {"1", "2"});

        var expected = "\"1\"";
        
        Assert.AreEqual(expected, actual);
    }

    [Test]
    public void TwoColumns_NullValues()
    {
        var actual = CsvHelper.GenerateRow(2, null);

        var expected = "\"\",\"\"";
        
        Assert.AreEqual(expected, actual);
    }

    [Test]
    public void TwoColumns_OneValue()
    {
        var actual = CsvHelper.GenerateRow(2, new [] {"1"});

        var expected = "\"1\",\"\"";
        
        Assert.AreEqual(expected, actual);
    }

    [Test]
    public void TwoColumns_TwoValuesWithDoubleQuotes()
    {
        var actual = CsvHelper.GenerateRow(2, new [] {"\"1\"", "\"2\""});

        var expected = "\"\"\"1\"\"\",\"\"\"2\"\"\"";
        
        Assert.AreEqual(expected, actual);
    }

    [Test]
    public void TwoColumns_TwoValue()
    {
        var actual = CsvHelper.GenerateRow(2, new [] {"1","2"});

        var expected = "\"1\",\"2\"";
        
        Assert.AreEqual(expected, actual);
    }
    
    [Test]
    public void TwoColumns_ThreeValue()
    {
        var actual = CsvHelper.GenerateRow(2, new [] {"1","2","3"});

        var expected = "\"1\",\"2\"";
        
        Assert.AreEqual(expected, actual);
    }
}
```