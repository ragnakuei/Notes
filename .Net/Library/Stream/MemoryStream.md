# MemoryStream

## 從檔案讀出，轉成 byte array，再轉成 memory stream，再存至另一個檔案

```csharp
void Main()
{
	var filePath = @"c:/temp/test.txt";
	
	var byteArray = ReadFileToByteArray(filePath);
	byteArray.Dump();

	var memoryStream = new MemoryStream(byteArray);
	var targetFile = @"c:/temp/test1.txt";
	SaveToFile(memoryStream, targetFile);
}

public byte[] ReadFileToByteArray(string filePath)
{
	using (var fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
	{
		byte[] bytes = new byte[fileStream.Length];
		fileStream.Read(bytes, 0, (int)fileStream.Length);
		return bytes;
	}
}

public void SaveToFile(Stream stream, string filePath)
{
	using (var fileStream = File.Create(filePath))
	{
		stream.Seek(0, SeekOrigin.Begin);
		stream.CopyTo(fileStream);
	}
}
```