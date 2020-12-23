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
