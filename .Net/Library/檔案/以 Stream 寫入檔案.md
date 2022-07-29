# 以 Stream 寫入檔案

二種方式：

#### 方式一

```csharp
var fileStream = File.Create("C:\\Path\\To\\File");
_stream.Seek(0, SeekOrigin.Begin);
_stream.CopyTo(fileStream);
fileStream.Close();
```

#### 方式二

```csharp
using (var fileStream = File.Create("C:\\Path\\To\\File"))
{
    _stream.Seek(0, SeekOrigin.Begin);
    _stream.CopyTo(fileStream);
}
```


#### 方式三 純字串

```cs
async Task Main()
{
	var lines = Enumerable.Range(1, 10).Select(line => $"line:{line}\n").ToArray();

	var file = @"C:\temp\test.txt";

	using (var fs = File.Open(file, FileMode.OpenOrCreate, FileAccess.Write, FileShare.Read))
	{
		var utf8 = new UTF8Encoding(true);
		
		// write line by line
		lines.Take(5).ForEach(async line =>
		{
			var info = utf8.GetBytes(line);
			await fs.WriteAsync(info, 0, info.Length);
		});
	}
	
	await PrintFileContentAsync(file);
	
	return;
}

private async Task PrintFileContentAsync(string file)
{
	using (var fileStream = File.Open(file, FileMode.Open, FileAccess.Read, FileShare.Read))
	{
		var bytes = new byte[fileStream.Length];
		var utf8 = new UTF8Encoding(true);

		while (await fileStream.ReadAsync(bytes, 0, bytes.Length) > 0)
		{
			Console.WriteLine(utf8.GetString(bytes));
		}
	}
}
```