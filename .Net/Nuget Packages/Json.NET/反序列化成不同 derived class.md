# 反序列化成不同 derived class

- 情境對照 [System.Text.Json 反序列化成不同 derived class](./../../Library/System.Text.Json.md#反序列化成不同-derived-class)

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


## 範例二

ReadJson() 的語法與範例一，稍微不同 !

```csharp
void Main()
{
    var data = new BaseType[]
    {
        new TypeA { Id = 1, },
        new TypeB { Name = "A" },
    };

    var json = JsonConvert.SerializeObject(data,
                                           Newtonsoft.Json.Formatting.Indented);
    json.Dump();

    var jsonSettings = new JsonSerializerSettings
    {
        Converters = new List<JsonConverter>
        {
            new BaseTypeConverter(),
        }
    };

    var data2 = JsonConvert.DeserializeObject<BaseType[]>(json, jsonSettings);
    data2.Dump();
}

public class BaseType
{
    public string Type { get; set; }
}

public class TypeA : BaseType
{
    public TypeA()
    {
        Type = "TypeA";
    }
    
    public int Id { get; set; }
}

public class TypeB : BaseType
{
    public TypeB()
    {
        Type = "TypeB";
    }

    public string Name { get; set; }
}

class BaseTypeConverter : JsonConverter
{
    public override bool CanConvert(Type objectType)
    {
        return typeof(BaseType).IsAssignableFrom(objectType);
    }

    public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
    {
        JObject item = JObject.Load(reader);
        switch (item[nameof(BaseType.Type)].Value<String>())
        {
            case "TypeA": return item.ToObject<TypeA>();
            case "TypeB": return item.ToObject<TypeB>();
            
            default: throw new ArgumentException("Invalid source type");
        }
    }

    public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
    {
        throw new NotImplementedException();
    }
}
```