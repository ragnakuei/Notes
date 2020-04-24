# [TextFieldParser](https://docs.microsoft.com/zh-tw/dotnet/api/microsoft.visualbasic.fileio.textfieldparser)

```csharp
using Microsoft.VisualBasic.FileIO;
```

建構子支援 `檔案` 或 `Steram`

支援
- .net framework 4.8
- .net core 3.1

> 注意： 不支援 .net standard

## Sample

```csharp
void Main()
{
	var str = @"A,B,""""""""""""""www.google.com""""""""
""""""""我就是要,來搞你"""""""""""""",D
";
	var strStream = ToStream(str);

	using (TextFieldParser parser = new TextFieldParser(strStream))
	{
		parser.Delimiters = new string[] { "," };
		while (true)
		{
			string[] parts = parser.ReadFields();
			if (parts == null)
			{
				break;
			}
			
			foreach (var p in parts)
			{
				Console.WriteLine(p);
			}
			
			Console.WriteLine("{0} field(s)", parts.Length);
		}
	}
}

public static Stream ToStream(string str)
{
	// var byteArray = Encoding.ASCII.GetBytes( str );
	var byteArray = Encoding.UTF8.GetBytes(str);
	var stream = new MemoryStream(byteArray);
	return stream;
}
```