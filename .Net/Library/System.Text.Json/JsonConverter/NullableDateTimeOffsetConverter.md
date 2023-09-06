# NullableDateTimeOffsetConverter

```cs
public class NullableDateTimeOffsetConverter : JsonConverter<DateTimeOffset?>
{
    private string _format = "yyyy-MM-dd HH:mm:ss.fffzzz";

    public override DateTimeOffset? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        if (DateTimeOffset.TryParseExact(reader.GetString(),
                                         _format,
                                         null,
                                         DateTimeStyles.None,
                                         out var result))
        {
            return result;
        }

        return null;
    }

    public override void Write(Utf8JsonWriter writer, DateTimeOffset? value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value?.ToString(_format));
    }
}
```