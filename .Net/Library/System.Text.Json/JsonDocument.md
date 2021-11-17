# JsonDocument


```cs
void Main()
{
    var dto = new Dto
    {
        Id = 1,
        Name = @"A""",
        Dtos = new Dto[]
        {
            new Dto { Id = 11, Name = @"A1" },
            new Dto { Id = 12, Name = @"A2" },
            new Dto { Id = 13, Name = @"A3" },
        }
    };
    
    //var expecJson = dto.ToJson().Replace("\"", "\"\"").Dump();
    
    var actualJson = @"{""Id"":1,""Name"":""A\u0022"",""Dtos"":[{""Id"":11,""Name"":""A1"",""Dtos"":null},{""Id"":12,""Name"":""A2"",""Dtos"":null},{""Id"":13,""Name"":""A3"",""Dtos"":null}]}";
    
    var actualObject = JsonDocument.Parse(actualJson).Dump();
    actualObject.RootElement.GetProperty("Id").Dump();
    actualObject.RootElement.GetProperty("Dtos").GetArrayLength().Dump();
    actualObject.RootElement.GetProperty("Dtos").EnumerateArray().FirstOrDefault().GetProperty("Id").Dump();
}

public class Dto
{
    public int Id { get; set; }
    
    public string Name { get; set; }
    
    public Dto[] Dtos { get; set; }
}
```