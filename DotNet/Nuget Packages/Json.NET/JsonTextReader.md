# JsonTextReader

逐行讀取 Json 格式資料

## 範例

```csharp
var jsonSrc = @"
{
  ""data"": {
    ""aa"": ""x"",
    ""bb"": ""y""
  },
  ""QQ"": ""z"",
  ""data"": {
    ""aa"": ""x"",
    ""bb"": ""y""
  }
}
";

// 即使 json 資料不換行，也是相同結果
// var jsonSrc = @"{ ""data"": { ""aa"": ""x"", ""bb"": ""y"" }, ""QQ"": ""z"", ""data"": { ""aa"": ""x"", ""bb"": ""y"" } }";

var reader = new JsonTextReader(new StringReader(jsonSrc));

while (reader.Read())
{
	if (reader.Value != null)
	{
		Console.WriteLine("Token: {0}, Value: {1}", reader.TokenType, reader.Value);
	}
	else
	{
		Console.WriteLine("Token: {0}", reader.TokenType);
	}
}
```
