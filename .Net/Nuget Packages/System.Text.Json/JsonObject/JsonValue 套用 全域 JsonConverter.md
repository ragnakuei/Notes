# JsonValue 套用 全域 JsonConverter

假設註冊了 Converter
```cs
public class NullableDateTimeOffsetConverter : JsonConverter<DateTimeOffset?> {}
```

在使用 JsonObject 給定其 value 時，要以 JsonValue.Create\<T>() 來建立 JsonValue，就可以套用 JsonConverter

其中型別 T 要與 Converter 的型別一致 !

```cs
var obj = new JsonObject();
obj.Add("TestDateTimeOffSet",
        JsonValue.Create<DateTimeOffset?>(DateTimeOffset.Now));

```
