# 讓 IEnumerable of T 也可以用 ForEach

```csharp
public static void ForEach<T>(this IEnumerable<T> source, Action<T> action)
{
    if (source == null)
    {
        return;
    }

    foreach (T obj in source)
    {
        action.Invoke(obj);
    }
}
```
