# ForEach

## 讓 IEnumerable of T 也可以用 ForEach

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

## ForEach 有 Index

```csharp
public static void ForEach<TElement>(this IEnumerable<TElement> source, Action<TElement, int> action)
{
    int index = 0;

    foreach (var item in source)
    {
        action.Invoke(item, index);
        index++;
    }
}
```