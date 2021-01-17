# [System.Text.Json](https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json-how-to)

-   支援 `JsonIgnore` 但要注意 namespace 是否引用正確
-   預設支援 Escape Html 功能

```csharp
JsonSerializer.Serialize(weatherForecast);
```

-   預設不會以子類 Type 的角度來序列化 (跟 Newton.Json 的預設行為不同)

## Escape Html 功能

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

## 反序列化成不同 derived class

-   [官方文件](https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json-converters-how-to#support-polymorphic-deserialization)
-   情境對照 [Newton.Json 反序列化成不同 derived class](./../Nuget%20Packages/Json.NET/反序列化成不同%20derived%20class.md)

### 範例一：Discriminator 欄位必須放在 json object 首個 property

-   Discriminator 欄位 為 Type
-   Discriminator 欄位必須放在 json object 首個 property

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

	// 與 Newton.Json 不同的點，Serialize 不會注意到子類 !
	var json1 = JsonSerializer.Serialize(dtos);
	json1.Dump();
	// [{"Type":"A"},{"Type":"A"},{"Type":"B"},{"Type":"B"},{"Type":"B"}]

	var serializeOptions = new JsonSerializerOptions();
	serializeOptions.Converters.Add(new BaseTypeDiscriminator());

	var json2 = JsonSerializer.Serialize(dtos, serializeOptions);
	json2.Dump();
	// [{"Type":"A","Id":1},{"Type":"A","Id":2},{"Type":"B","Name":"B1"},{"Type":"B","Name":"B2"},{"Type":"B","Name":"B3"}]

	JsonSerializer.Deserialize<BaseType[]>(json2, serializeOptions).Dump();
}

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

// 如果 Type 欄位不在 json 第一順序，會很麻煩
public class BaseTypeDiscriminator : JsonConverter<BaseType>
{
	public override bool CanConvert(Type typeToConvert) => typeof(BaseType).IsAssignableFrom(typeToConvert);

	/// <summary>
	/// 反序列化 - 注意：有順序性
	/// </summary>
	public override BaseType Read(ref Utf8JsonReader reader,
								  Type typeToConvert,
								  JsonSerializerOptions options)
	{
		// 讀取物件起始
		if (reader.TokenType != JsonTokenType.StartObject)
		{
			throw new JsonException();
		}

		// 必須先把 Discriminator 欄位:Type 放在 json 格式的第一順位
		// 為的只是先決定好要產生哪種子類
		reader.Read();
		if (reader.TokenType != JsonTokenType.PropertyName)
		{
			throw new JsonException();
		}

		// 讀取 Property Name
		string propertyName = reader.GetString();
		if (propertyName != "Type")
		{
			throw new JsonException();
		}

		// 判斷 Type 的型態是否正確
		reader.Read();
		if (reader.TokenType != JsonTokenType.String)
		{
			throw new JsonException();
		}

		// 讀取 Property Value
		var type = reader.GetString();

		// 依照 type 建立對應子類
		BaseType result = type switch
		{
			"A" => new ChildTypeA(),
			"B" => new ChildTypeB(),
			_ => throw new JsonException()
		};

		result.Type = type;

		// 子類 Property 讀取
		while (reader.Read())
		{
			// 所有 Property 讀取完畢
			if (reader.TokenType == JsonTokenType.EndObject)
			{
				return result;
			}

			if (reader.TokenType == JsonTokenType.PropertyName)
			{
				// 讀取 Property Name
				propertyName = reader.GetString();

				// 讀取 Property Value
				reader.Read();
				switch (propertyName)
				{
					case "Id":
						var Id = reader.GetInt32();
						((ChildTypeA)result).Id = Id;
						break;
					case "Name":
						var name = reader.GetString();
						((ChildTypeB)result).Name = name;
						break;
				}
			}
		}

		throw new JsonException();
	}

	/// <summary>
	/// 序列化
	/// </summary>
	public override void Write(Utf8JsonWriter writer,
							   BaseType serializeObject,
							   JsonSerializerOptions options)
	{
		writer.WriteStartObject();

		// 為了讓反序列化比較好處理，Discriminator 欄位必須先給定
		writer.WriteString("Type", serializeObject.Type);

		if (serializeObject is ChildTypeA childTypeA)
		{
			writer.WriteNumber("Id", childTypeA.Id);
		}
		else if (serializeObject is ChildTypeB childTypeB)
		{
			writer.WriteString("Name", childTypeB.Name);
		}

		writer.WriteEndObject();
	}
}
```

### 範例二：Discriminator 欄位不必放在 json object 首個 property

-   Discriminator 欄位 為 Type
-   Discriminator 欄位不必放在 json object 首個 property

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

	// 與 Newton.Json 不同的點，Serialize 不會注意到子類 !
	var json1 = JsonSerializer.Serialize(dtos);
	json1.Dump();
	// [{"Type":"A"},{"Type":"A"},{"Type":"B"},{"Type":"B"},{"Type":"B"}]

	var serializeOptions = new JsonSerializerOptions();
	serializeOptions.Converters.Add(new BaseTypeDiscriminator());

	var json2 = JsonSerializer.Serialize(dtos, serializeOptions);
	json2.Dump();
	// [{"Id":1,"Type":"A"},{"Id":2,"Type":"A"},{"Name":"B1","Type":"B"},{"Name":"B2","Type":"B"},{"Name":"B3","Type":"B"}]

	JsonSerializer.Deserialize<BaseType[]>(json2, serializeOptions).Dump();
}

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

// 如果 Type 欄位不在 json 第一順序，會很麻煩
public class BaseTypeDiscriminator : JsonConverter<BaseType>
{
	public override bool CanConvert(Type typeToConvert) => typeof(BaseType).IsAssignableFrom(typeToConvert);

	/// <summary>
	/// 反序列化 - 注意：有順序性
	/// </summary>
	public override BaseType Read(ref Utf8JsonReader reader,
								  Type typeToConvert,
								  JsonSerializerOptions options)
	{
		// 讀取物件起始
		if (reader.TokenType != JsonTokenType.StartObject)
		{
			throw new JsonException();
		}

		// 先宣告所有子類的 Property
		string type = default;
		int id = default;
		string name = default;

		// 讀取 json 所有 Property
		while (reader.Read())
		{
			// 所有 Property 讀取完畢
			if (reader.TokenType == JsonTokenType.EndObject)
			{
				break;
			}

			if (reader.TokenType == JsonTokenType.PropertyName)
			{
				// 讀取 Property Name
				var propertyName = reader.GetString();

				// 讀取 Property Value
				reader.Read();
				switch (propertyName)
				{
					case "Id":
						id = reader.GetInt32();
						break;
					case "Name":
						name = reader.GetString();
						break;
					case "Type":
						type = reader.GetString();
						break;
				}
			}
		}

		// 依照 type 建立對應子類
		return type switch
		{
			"A" => new ChildTypeA {
				Type = type,
				Id = id,
			},
			"B" => new ChildTypeB {
				Type = type,
				Name = name,
			},
			_ => throw new JsonException()
		};
	}

	/// <summary>
	/// 序列化
	/// </summary>
	public override void Write(Utf8JsonWriter writer,
							   BaseType serializeObject,
							   JsonSerializerOptions options)
	{
		writer.WriteStartObject();

		if (serializeObject is ChildTypeA childTypeA)
		{
			writer.WriteNumber("Id", childTypeA.Id);
		}
		else if (serializeObject is ChildTypeB childTypeB)
		{
			writer.WriteString("Name", childTypeB.Name);
		}

		// 故意將 Discriminator 欄位 放在最後面
		writer.WriteString("Type", serializeObject.Type);

		writer.WriteEndObject();
	}
}
```
