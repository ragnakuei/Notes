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

## 壓縮

### 範例：從記憶體內建立壓縮檔，再以 Stream 寫入

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

### 範例：從記憶體內建立壓縮檔，再以放入實體檔案

```csharp
using var memoryStream = new MemoryStream();

// 此處不能用 using var
using (ZipArchive zipArchive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
{
	zipArchive.CreateEntryFromFile("c:\\temp\\test1.txt", "a\\example1.txt");
	zipArchive.CreateEntryFromFile("c:\\temp\\test2.txt", "b\\example2.txt");
}

File.WriteAllBytes("c:\\temp\\compressedFile3.zip", memoryStream.ToArray());
```

如果使用以下語法，就會產生 IOException: Entries cannot be created while previously created entries are still open.

簡單說，用錯語法了 !

```csharp
using var memoryStream = new MemoryStream();

// 此處不能用 using var
using (ZipArchive zipArchive = new ZipArchive(memoryStream, ZipArchiveMode.Create, true))
{
	AddFile(zipArchive, "a\\example1.txt", "c:\\temp\\test1.txt");
	AddFile(zipArchive, "b\\example2.txt", "c:\\temp\\test2.txt");
}

File.WriteAllBytes("c:\\temp\\compressedFile3.zip", memoryStream.ToArray());

void AddFile(ZipArchive zipArchive, string entryPath, string filePath)
{
	var entry = zipArchive.CreateEntry(entryPath);
	using (var fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read))
	{
		fileStream.CopyTo(entry.Open());
		fileStream.Close();
	}
}
```