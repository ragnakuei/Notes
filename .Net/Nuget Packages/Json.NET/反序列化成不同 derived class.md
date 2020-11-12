# 反序列化成不同 derived class

- 情境對照 [System.Text.Json 反序列化成不同 derived class](./../../Library/System.Text.Json.md##%20反序列化成不同%20derived%20class)

## 範例一

### 物件定義

```csharp
public class BaseType
{
	public string Type { get; set; }
}

public class ChildTypeA : BaseType
{
	public int Id { get; set; }
}

public class ChildTypeB : BaseType
{
	public string Name { get; set; }
}
```

### 新增 JsonConverter

```csharp
public class BaseTypeConverter : Newtonsoft.Json.JsonConverter
{
	public override bool CanConvert(Type objectType)
	{
		return (objectType == typeof(BaseType));
	}

	public override object ReadJson(JsonReader reader, Type objectType, object existingValue, Newtonsoft.Json.JsonSerializer serializer)
	{
		JObject jo = JObject.Load(reader);
		if (jo["Type"].Value<string>() == "A")
			return jo.ToObject<ChildTypeA>(serializer);

		if (jo["Type"].Value<string>() == "B")
			return jo.ToObject<ChildTypeB>(serializer);

		return null;
	}

	public override bool CanWrite
	{
		get { return false; }
	}

	public override void WriteJson(JsonWriter writer, object value, Newtonsoft.Json.JsonSerializer serializer)
	{
		throw new NotImplementedException();
	}
}
```

### 執行語法

```csharp
void Main()
{
	var dtos = new BaseType[] {
		new ChildTypeA { Type = "A", Id = 1, },
		new ChildTypeA { Type = "A", Id = 2, },
		new ChildTypeB { Type = "B", Name = "B1", },
		new ChildTypeB { Type = "B", Name = "B2", },
		new ChildTypeB { Type = "B", Name = "B3", },
	};
	var options = new JsonSerializerSettings
	{
		 Converters = { new BaseTypeConverter() }
	};
	var json = JsonConvert.SerializeObject(dtos, options);
	JsonConvert.DeserializeObject<BaseType[]>(json, options).Dump();
}
```
