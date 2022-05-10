# Generic

### object to generic / object 物件轉成泛型 T

-   [JValue](../../Nuget%20Packages/Json.NET/JValue.md)

```cs
void Main()
{
	var values = new object[] { 1, "1", 1.2, "1.2", 3.4f, 5L, "999999" };

	foreach (var value in values)
	{
		Convert01<short>(value).Dump();
		Convert02<short>(value).Dump();
		Convert03<short>(value).Dump();
		Convert04<short>(value).Dump();
		"-------------------------".Dump();
	}
}

private T Convert01<T>(object o)
{
	try
	{
		Expression convertExpr = Expression.Convert(Expression.Constant(o), typeof(T));

		return Expression.Lambda<Func<T>>(convertExpr).Compile()();
	}
	catch (Exception ex)
	{
		//throw;
		"Convert01 Failed".Dump();
	}
	return default;
}

/// <summary>
/// TypeConverter
/// </summary>
private T Convert02<T>(object o)
{
	try
	{
		var converter = TypeDescriptor.GetConverter(typeof(T));

		return (T)converter.ConvertFrom(o);
	}
	catch (Exception ex)
	{
		//throw;
		"Convert02 Failed".Dump();
	}
	return default;
}

/// <summary>
/// Json.NET JValue
/// </summary>
private T Convert03<T>(object o)
{
	try
	{
		var v = new JValue(o);

		return v.ToObject<T>();
	}
	catch (Exception ex)
	{
		//throw;
		"Convert03 Failed".Dump();
	}
	return default;
}

private T Convert04<T>(object o)
{
	try
	{
		return (T)Convert.ChangeType(o, typeof(T));
	}
	catch (Exception ex)
	{
		//throw;
		"Convert04 Failed".Dump();
	}
	return default;
}
```

#### 特殊範例

```cs
/// <summary>
/// 可轉型的
/// DateTime 取其分鐘
/// Boolean true 為 1，false 為 0
/// 其餘可轉型則轉，否則為 0
/// </summary>
public class PraseObject
{
    public T[] Parse<T>(object[] items)
    {
        var result = new T[items.Length];

        for (var i = 0; i < items.Length; i++)
        {
            if (items[i] is bool b)
            {
                result[i] = Parse<T>(b ? "1" : "0");
                continue;
            }

            result[i] = Parse<T>(items[i]?.ToString() ?? string.Empty);
        }

        return result;
    }

    private T Parse<T>(string s)
    {
        try
        {
            return (T)Convert.ChangeType(s, typeof(T));
        }
        catch (Exception e)
        {
            if (TryParseDateTime(s, out var dt))
            {
                return Parse<T>(dt.GetValueOrDefault().Minute.ToString());
            }

            if (TryParseBool(s, out var b))
            {
                return Parse<T>(b.GetValueOrDefault() ? "1" : "0");
            }

            return Parse<T>("0");
        }
    }

    private bool TryParseDateTime(string item, out DateTime? result)
    {
        if (DateTime.TryParse(item, out DateTime dateTimeValue))
        {
            result = dateTimeValue;
            return true;
        }

        result = null;

        return false;
    }

    private bool TryParseBool(string item, out bool? result)
    {
        if (Boolean.TryParse(item, out bool boolValue))
        {
            result = boolValue;
            return true;
        }

        result = null;

        return false;
    }
}
```
