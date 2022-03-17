# JValue

- 可以用這個物件提供的 api ，將不定型別的 json 轉成想要的型別


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
    var v = new JValue(o);
    return v.ToObject<T>();
}
```

