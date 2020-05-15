# Deep Clone

## 可 Serialize 的物件

```csharp
public static T DeepClone<T>(T obj)
{
    using (var ms = new MemoryStream())
    {
        var formatter = new BinaryFormatter();
        formatter.Serialize(ms, obj);
        ms.Position = 0;

        return (T) formatter.Deserialize(ms);
    }
}
```

## 不可 Serialize 的物件

