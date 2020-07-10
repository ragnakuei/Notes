# 取出 Property Name

```csharp
void Main()
{
	var test = new Test();
	Helper.GetExpressionPropertyName<Test, int>(t => t.Id).Dump();
}

public static class Helper
{
    internal static string GetExpressionPropertyName<TSource, TKey>(Expression<Func<TSource, TKey>> expression)
    {
        var memberExpression = expression?.Body as MemberExpression;
        var propertyName = memberExpression.Member?.Name;
        return propertyName;
    }
}

public class Test
{
    public int Id { get; set; }
    public string Name { get; set; }
}
```
