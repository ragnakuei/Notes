# 呼叫 Extension Method 並給定參數

```csharp
void Main()
{
    typeof(MyExtension).GetMethods()
                        .FirstOrDefault(m => m.Name.Equals("Test", StringComparison.CurrentCultureIgnoreCase)
                                         && m.IsGenericMethod
                                         && m.GetParameters().Length == 3)
                        .MakeGenericMethod(typeof(int), typeof(string))
                        .Invoke(null, new object[] { "s", 1, "2" }).Dump();

    typeof(MyExtension).GetMethods()
                        .FirstOrDefault(m => m.Name.Equals("Test", StringComparison.CurrentCultureIgnoreCase)
                                         && m.IsGenericMethod
                                         && m.GetParameters().Length == 4)
                        .MakeGenericMethod(typeof(int), typeof(string), typeof(int))
                        .Invoke(null, new object[] { "s", 1, "2", 3 }).Dump();
}

public static class MyExtension
{
    public static string Test<T1, T2>(this string s, T1 t1, T2 t2)
    {
        return $"{s}.{t1}.{t2}";
    }

    public static string Test<T1, T2, T3>(this string s, T1 t1, T2 t2, T3 t3)
    {
        return $"{s}.{t1}.{t2}.{t3}";
    }
}
```
