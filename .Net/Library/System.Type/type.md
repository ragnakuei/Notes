# type

## [IsAssignableFrom](https://docs.microsoft.com/zh-tw/dotnet/api/system.type.isassignablefrom?view=netcore-3.1)

a.IsAssignableFrom(b)

b 是否可指派給 a

```csharp
void Main()
{
    typeof(Parent).IsAssignableFrom(typeof(Child)).Dump();
}

public interface Parent { }
public class Child : Parent { }
```
