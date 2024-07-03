# 不做 UTF-8 Encoding 的方式

```cs
void Main()
{
	var dto = new DTO {
		Name = "一二三"
	};

	dto.ToJson().Dump();

	var options = new JsonSerializerOptions
	{
		//Encoder = JavaScriptEncoder.Create(UnicodeRanges.All),
		Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping,
		WriteIndented = true
	};
	dto.ToJson(options).Dump();
}

public class DTO
{
	public string Name { get; set; }
}
```
