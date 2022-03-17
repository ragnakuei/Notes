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