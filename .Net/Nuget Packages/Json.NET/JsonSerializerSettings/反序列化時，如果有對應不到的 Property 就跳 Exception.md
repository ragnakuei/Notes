# 反序列化時，如果有對應不到的 Property 就跳 Exception


```csharp
void Main()
{
    var dtos = new TestDto[]
    {
        new TestDto { Id = 1, Name = "A" },
        new TestDto { Id = 2, Name = "B" },
        new TestDto { Id = 3, Name = "C" },
    };
    
    var json = JsonConvert.SerializeObject(dtos);
    
    json.Dump("json");
    
    json = json.Replace("Name", "NameA");

    dtos = JsonConvert.DeserializeObject<TestDto[]>(json, new JsonSerializerSettings
    {
        // 這個要指定為 Error (預設為 Ignore)
        MissingMemberHandling = MissingMemberHandling.Error,
    });
    
    dtos.Dump();
}

public class TestDto
{ 
    public int Id { get; set; }
    
    public string Name { get; set; }
}
```