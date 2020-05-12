# [Encoding](https://docs.microsoft.com/zh-tw/dotnet/api/system.text.encoding)

## 常用編碼

| 編碼            | bits |
| --------------- | ---- |
| ASCIIEncoding   | 7    |
| UTF7Encoding    | 7    |
| UTF8Encoding    | 8    |
| UnicodeEncoding | 16   |
| UTF32Encoding   | 32   |


## 從字串轉成對應的 Enconding

```csharp
System.Text.Encoding.GetEncoding("big5")
```