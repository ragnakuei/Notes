# MemoryStream

#### 從檔案讀出，轉成 memory steam 再全部轉成 string

- 測試同時讀出十個檔
- 只將第一個檔轉成字串

```cs
async Task Main()
{
    var filePath = @"c:\temp\tib1.txt";
    
    var tasks = Enumerable.Range(1,10).Select(i => ReadFileAsync(filePath)).ToArray();
    
    var fileContents = await Task.WhenAll(tasks);
    
    fileContents.Length.Dump();
    
    using (var reader = new StreamReader(fileContents[0]))
    {
        reader.ReadToEnd().Dump();
    }
}

public async Task<MemoryStream> ReadFileAsync(string filePath)
{
    using (var fs = new FileStream(filePath, FileMode.Open, FileAccess.Read))
    {
        await Task.Delay(1000);
        
        var memeoryStream = new MemoryStream();
        
        fs.CopyTo(memeoryStream);
		fileContents[0].Position = 0;
        
        return memeoryStream;
    }
}
```

#### 從檔案讀出，轉成 byte array，再轉成 memory stream，再存至另一個檔案

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