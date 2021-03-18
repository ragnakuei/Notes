# 動態給定 property name 組成 where string contains

[參考資料](https://stackoverflow.com/questions/278684/how-do-i-create-an-expression-tree-to-represent-string-containsterm-in-c)


```csharp
class Program
{
    static void Main(string[] args)
    {
        var tests = new[]
                    {
                        new Test { Name = "ABC" },
                        new Test { Name = "DEF" },
                        new Test { Name = "ACE" },
                    };

        var result = tests.Where(t => BuildWhereExpression<Test>("Name", "E").Invoke(t));

        foreach (var r in result)
        {
            Console.WriteLine(r.Name);
        }
    }

    public static Func<T, bool> BuildWhereExpression<T>(string propertyName, string keyword)
    {
        if (typeof(T).GetProperties().Any(p => p.Name.Equals(propertyName, StringComparison.CurrentCultureIgnoreCase) == false))
        {
            return null;
        }

        var parameterExpression = Expression.Parameter(typeof(T), nameof(T).ToLower());
        var propertyExpression  = Expression.Property(parameterExpression, propertyName);

        var method = typeof(string).GetMethod("Contains", new[] { typeof(string) });

        var constExpression = Expression.Constant(keyword);

        var containsMethodExp = Expression.Call(propertyExpression, method, constExpression);

        return Expression.Lambda<Func<T, bool>>(containsMethodExp, parameterExpression).Compile();
    }
}


public class Test
{
    public string Name { get; set; }
}
```