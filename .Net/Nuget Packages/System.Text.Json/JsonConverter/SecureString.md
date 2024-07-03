# SecureStringJsonConverter


```cs
void Main()
{
	var json = @"{ 
		""Account"":""Test"",
		""Password"":""1234"" 
	}";


	var dto = JsonSerializer.Deserialize<LoginDto>(json);
	dto.Dump();

	var json2 = JsonSerializer.Serialize(dto);
	json2.Dump();
}

public class LoginDto
{
	public string Account { get; set; }

	[JsonConverter(typeof(SecureStringJsonConverter))]
	public SecureString Password { get; set; }
}

public class SecureStringJsonConverter : JsonConverter<SecureString>
{
	public override SecureString Read(ref Utf8JsonReader reader,
									Type typeToConvert,
									JsonSerializerOptions options)
	{
		var inputString = reader.GetString();
		var result = new SecureString();

		if (string.IsNullOrWhiteSpace(inputString) == false)
		{
			foreach (var inputChar in inputString)
			{
				result.AppendChar(inputChar);
			}
		}

		return result;
	}

	public override void Write(Utf8JsonWriter writer,
								SecureString secureString,
								JsonSerializerOptions options)
	{


		IntPtr ptr = Marshal.SecureStringToBSTR(secureString);
		writer.WriteStringValue(Marshal.PtrToStringBSTR(ptr));
		Marshal.ZeroFreeBSTR(ptr);
	}
}
```
