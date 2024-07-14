# JsonConverter

套用注意事項

- 該 Property 也要在 Json 內有給定，否則會被忽略
- Nullable Reference Type
  - 型態最好一致
  - 如果是 int? 型態，用在 int 上時，可能會遇到非預期的效果 !
- 該 json property 未給定時，不會觸發 JsonConverter
- json property 值為 null 時
  - 如果 Converter 未指定 HandleNull 為 true 時，則不會觸發 JsonConverter !
  
    ```cs
    public class StringConverter : JsonConverter<string>
    {
        // 要處理 null 值 !
        public override bool HandleNull => true;
        
        public override string? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            // TODO
        }

        public override void Write(Utf8JsonWriter writer, string? value, JsonSerializerOptions options)
        {
            // TODO
        }
    }
    ```

- 