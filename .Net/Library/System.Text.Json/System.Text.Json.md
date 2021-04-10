# [System.Text.Json](https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json-how-to)

-   支援 `JsonIgnore` 但要注意 namespace 是否引用正確
-   預設支援 Escape Html 功能

```csharp
JsonSerializer.Serialize(weatherForecast);
```

-   預設不會以子類 Type 的角度來序列化 (跟 Newton.Json 的預設行為不同)

