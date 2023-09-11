# ZipArchive

### 範例：解壓 MemoryStram 至指定資料夾

```csharp
public void ExtractToDirectory(Stream compressFileStream, string tempFolderPath)
{
    using (var zipArchive = new ZipArchive(compressFileStream, ZipArchiveMode.Read))
    {
        zipArchive.ExtractToDirectory(tempFolderPath);
    }
}
```

### 範例：從記憶體內建立壓縮檔，再寫入指定檔案中

```csharp
using var memoryStream = new MemoryStream();

// 此處不能用 using var
using (ZipArchive zipArchive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
{
	var entry = zipArchive.CreateEntry("a\\example1.txt");
	using (var writer = new StreamWriter(entry.Open()))
	{
		writer.Write("a example1");
	}

	entry = zipArchive.CreateEntry("b\\example2.txt");
	using (StreamWriter writer = new StreamWriter(entry.Open()))
	{
		writer.Write("b example2");
	}
}

File.WriteAllBytes("c:\\temp\\compressedFile2.zip", memoryStream.ToArray());
```