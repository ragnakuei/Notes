# 複製 Rows

```csharp
// 讀取 excel 檔
var workbook = new Workbook(exportFileDto.TemplateFile);

// target.CopyRows(source, sourceRowIndex, targetRowIndex, RowCount)
sheet.Cells.CopyRows(sheet.Cells, 0, 41, 42);

// 寫入另一個 excel 檔
workbook.Save(exportFileDto.OutputFile);
```
