# [SharpCompress](https://github.com/adamhathcock/sharpcompress)

用來處理多種壓縮格式 !

- 7zip
  - 只支援解壓，不支援壓縮


## 範例

### 解壓縮

```csharp
var readerOptions = new ReaderOptions();

using (var archive = ArchiveFactory.Open(compressFileStream, readerOptions))
{
    foreach (var entry in archive.Entries)
    {
        entry.WriteToDirectory(tempFolderPath,
                                new ExtractionOptions()
                                {
                                    ExtractFullPath = true,
                                    Overwrite       = true
                                });
    }
}
```