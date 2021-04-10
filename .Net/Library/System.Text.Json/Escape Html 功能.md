# Escape Html 功能

這個做法只是示範怎麼設定 Encode，不建議關閉 Escape Html 功能

- JavaScriptEncoder.Default - 預設，具有 Escape Html 功能
- JavaScriptEncoder.UnsafeRelaxedJsonEscaping - 關閉 Escape Html 功能

[相關連結](https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json-character-encoding#serialize-all-characters)


```csharp
void Main()
{
    var t = new TestDto
    {
        Id = 1,
        Name = "A </script>",
    };


    JsonSerializer.Serialize(t, 
                             new JsonSerializerOptions 
                             { 
                                // Encoder = JavaScriptEncoder.Default 
								Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping 
                             }).Dump();
}

public class TestDto
{
    public int Id { get; set; }

    public string Name { get; set; }
}
```

