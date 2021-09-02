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

## 套用 dynamic + JObject

```csharp
var json = @"
{
    ""A"" : 1,
    ""B"" : {
        ""B1"" : 21,
        ""B2"" : 22,
    },
}
";

var result = JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(json);

(result["B"] as JObject)["B2"].Dump();
```

## 不要用 dynamic + JObject

```csharp
void Main()
{
	var json = @"
	{
	    ""A"" : 1,
	    ""B"" : {
	        ""B1"" : 21,
	        ""B2"" : 22,
	    },
	}
	";

	var result = JsonConvert.DeserializeObject<TestDto>(json);

	result.B["B2"].Dump();
}

public class TestDto
{
	public int A { get; set; }

	public JObject B { get; set; }
}
```
