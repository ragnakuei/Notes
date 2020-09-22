# record

-   reference type
-   immutable

## positional records

```csharp
public record Test(int id, string Name);
```

## with

從既有的 record 複製一份 instance，可給定不同的 property 值

```csharp
Person brother = person with { FirstName = "Paul" };
```
