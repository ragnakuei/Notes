# Generic


### object to generic / object 物件轉成泛型 T

- [跟 JValue 能達成幾乎一樣的效果](../../Nuget%20Packages/Json.NET/JValue.md)

```cs
void Main()
{
    object o = false;
    Parse<bool>(o).Dump("bool");
    
    o = 2;
    Parse<Int16>(o).Dump("int16");
    Parse<Int32>(o).Dump("int32");
    Parse<Int64>(o).Dump("int64");

    o = "false";
    Parse<bool>(o).Dump("bool");
    
    o = 0;
    Parse<bool>(o).Dump("bool");
    
    o = 1;
    Parse<bool>(o).Dump("bool");
}

private T Parse<T>(object o)
{
    //var v = new JValue(o);
    //return v.ToObject<T>();

    if (o is T)
    {
        return (T)o;
    }
    try
    {
        return (T)Convert.ChangeType(o, typeof(T));
    }
    catch (InvalidCastException)
    {
        throw ;
        //return default(T);
    }
}
```

#### 範例

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