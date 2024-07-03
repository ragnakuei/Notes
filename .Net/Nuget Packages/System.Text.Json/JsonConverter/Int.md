# Int

```cs
public class TestDto
{
    [JsonConverter(typeof(NullableIntConverter))]
    // [JsonConverter(typeof(IntConverter))]
    public int? Id { get; set; }

    [Required]
    [StringLength(50)]
    public string Name { get; set; }
}
```

```cs
public class NullableIntConverter : JsonConverter<int?>
{
    public override int? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        if (Int32.TryParse(reader.GetString(), out var result))
        {
            return result;
        }

        return null;
    }

    public override void Write(Utf8JsonWriter writer, int? value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString());
    }
}

public class IntConverter : JsonConverter<int>
{
    public override int Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        if (Int32.TryParse(reader.GetString(), out var result))
        {
            return result;
        }

        // 自訂錯誤訊息
        // ModelState 的 Key 為 $.Id
        throw new JsonException("轉換成 Int 失敗");
    }

    public override void Write(Utf8JsonWriter writer, int value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString());
    }
}
```
