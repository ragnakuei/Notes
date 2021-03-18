# record

-   reference type
-   immutable
-   compare with property values - most important
-   [說明影片](https://channel9.msdn.com/Shows/On-NET/C-9-Language-Features)

## positional records

```csharp
public record Test(int id, string Name);
```

## with

- 從既有的 record 複製一份 instance，可給定不同的 property 值
- 換個角度思考，就是要改變 immutable 的特性

```csharp
Person brother = person with { FirstName = "Paul" };
```
