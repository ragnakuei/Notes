# [Pattern matching enhancements](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-9#pattern-matching-enhancements)


## 範例

```csharp
void Main()
{
    var p = new Person(18, "Tom");
    
    var ageStatus = p.Age switch 
    {
        < 18 => "未成年",
        >= 18 => "成年"
    };
    
    ageStatus.Dump();

    var fullStatus = p switch
    {
        (_, "Tom") => p.Age switch
        {
            < 18 => "Tom 未成年",
            >= 18 => "Tom 成年"
        }
    };
    
    fullStatus.Dump();
}

public record Person(int Age, string Name);
```
