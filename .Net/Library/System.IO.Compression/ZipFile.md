# [ZipFile](https://docs.microsoft.com/en-us/dotnet/api/system.io.compression.zipfile) 

```csharp
public MemoryStream CompressFolder(string processDtoTempFolderPath, string compressFilePath)
{
    ZipFile.CreateFromDirectory(processDtoTempFolderPath, compressFilePath);

    var memoryStream = new MemoryStream();
    using (var fileStream = File.Open(compressFilePath, FileMode.Open))
    {
        fileStream.CopyTo(memoryStream);

        memoryStream.Seek(0, SeekOrigin.Begin);
    }

    return memoryStream;
}
```