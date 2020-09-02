# Stream

建議指定 Encoding 避免前後轉換的 Encoding 不一致，而導致亂碼

## 複製至 MemoryStream 的方式

```csharp
public async Task<Stream> GetFileStream(string name)
{
    var filePath = Path.Combine(_rootFolder, _webFolder, _fileNamePathMap.GetValue(name));

    MemoryStream result = new MemoryStream();

    using (var fileStream = File.OpenRead(filePath))
    {
        await fileStream.CopyToAsync(result);

        // 一定要記得把 pointer 移回起始處
        result.Seek(0, SeekOrigin.Begin);
    }

    return result;
}
```
