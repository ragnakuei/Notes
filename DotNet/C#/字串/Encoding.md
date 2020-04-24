# Encoding

| 成員                       | 說明              |
| -------------------------- | ----------------- |
| Encoding.GetBytes(strigng) | 將字串轉成 byte[] |


## 轉換

```csharp
void Main()
{
	var str = @"ABC一二三";
	var strStream = ToMemoryStream(str, Encoding.Default);
	//var strStream = ToMemoryStream(str, Encoding.ASCII);
	//var strStream = ToMemoryStream(str, Encoding.UTF8);
	var result = ToString(strStream);
	result.Dump();
}

public static MemoryStream ToMemoryStream(string str, Encoding encoding = null)
{
	if (encoding == null)
	{
		encoding = Encoding.Default;
	}

	var byteArray = encoding.GetBytes(str);
	var stream = new MemoryStream(byteArray);
	return stream;
}

public static string ToString(Stream stream)
{
	var reader = new StreamReader(stream);
	var result = reader.ReadToEnd();
	return result;
}
```

