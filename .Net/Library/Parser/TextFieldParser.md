# [TextFieldParser](https://docs.microsoft.com/zh-tw/dotnet/api/microsoft.visualbasic.fileio.textfieldparser)

[在 C# 中解析 CSV 檔案](https://www.delftstack.com/zh-tw/howto/csharp/csharp-parse-csv/)


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

### Sample2
- 支援多筆換行

```cs
void Main()
{
	var str = @"A,B,""C """"
D"",E
A1,B1,""C1 """"
D1"",E1
";
	var strStream = ToStream(str);

	using (var parser = new TextFieldParser(strStream))
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
				Console.WriteLine("----------");
			}

			Console.WriteLine("{0} field(s)", parts.Length);
			Console.WriteLine("=================");
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