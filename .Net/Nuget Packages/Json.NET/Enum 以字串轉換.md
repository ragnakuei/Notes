# Enum 以字串轉換


```cs
void Main()
{
    var dto = new TestDto
    {
        Role = Role.User,
    };
    
    JsonConvert.SerializeObject(dto).Dump();

    // 反序列化，如果無對應的 Enum 就會產生 Exception
    var json = "{\"Role\":\"A\"}";
	JsonConvert.DeserializeObject<TestDto>(json).Dump();
}

public class TestDto
{
    [JsonConverter(typeof(StringEnumConverter))]
    public Role Role { get; set; }
}

public enum Role
{
    Administrator,
    User,
    Guest,
}
```