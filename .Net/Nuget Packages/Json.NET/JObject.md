# JObject

## 直接取出該階層下的值

```csharp
var json = @"
{
    ""A"" : 1,
    ""B"" : {
        ""B1"" : 11,
        ""B2"" : 12
    }
}
";

var target = JObject.Parse(json);

target["B"]["B2"].ToString().Dump();
```