# 複製 sheet

## 複製第一個 sheet 至第二個 sheet

```csharp
// 讀取 excel 檔
var workbook = new Workbook(exportFileDto.TemplateFile);

// target.Copy(source)
workbook.Worksheets[1].Copy(workbook.Worksheets[0]);

// 寫入另一個 excel 檔
workbook.Save(exportFileDto.OutputFile);
```
