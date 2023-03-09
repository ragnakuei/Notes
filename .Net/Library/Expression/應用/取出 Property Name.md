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
        MemberExpression? memberExpression = null;
        
        if(expression.Body is UnaryExpression u)
        {
            // value type
            memberExpression = u.Operand as MemberExpression;
        }
        else {
            // nullable value type
            memberExpression = expression.Body as MemberExpression;
        }
        
        var propertyName = memberExpression?.Member.Name;
        return propertyName;
    }
}

public class Test
{
    public int Id { get; set; }
    public string Name { get; set; }
}
```



### 範例

```cs
void Main()
{
    var dto = new TestDto
    {
        Id = 1,
        Name = "A",
    };
    
    ValidateString(dto, funcDto => funcDto.Id);
    ValidateString(dto, funcDto => funcDto.Name);
}

public void ValidateString<T>(T dto,Expression<Func<T, int>> expression)
{
    GetPropertyName(expression).Dump();
}

public void ValidateString<T>(T dto,Expression<Func<T, string>> expression)
{
    GetPropertyName(expression).Dump();
}

public string GetPropertyName<T, TKey>(Expression<Func<T, TKey>> expression)
{
    var memberExpression = expression?.Body as MemberExpression;
    var propertyName = memberExpression.Member?.Name;
    return propertyName;
}

public class TestDto
{
    public int Id { get; set; }
    
    public string Name { get; set; }
}
```


### 範例

```cs
void Main()
{
	Expression<Func<TestDto, bool>> e = t => t.Id == 0;

	if (e.Body is BinaryExpression b
	&& b.Left is MemberExpression m)
	{
		m.Member.Name.Dump();
	}
}

public class TestDto
{
	public int Id { get; set; }
}
```