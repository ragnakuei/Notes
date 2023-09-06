# 讓 cell 可以自動換行

- 如需自動設定列高，可參考 [[C#]NPOI匯出Excel遇到資料換行的問題](https://dotblogs.com.tw/jimmyyu/2010/03/09/13952)

```cs
private void InsertDtosSheet(Dto[] dtos, XSSFWorkbook workbook)
{
    var sheet    = workbook.CreateSheet("SheetA");
    var rowIndex = 0;

    // 寫入類型
    sheet.CreateRow(rowIndex++).CreateCell(0).SetCellValue("TypeA01");

    var columIndex = 0;
    var dtoColumns = new List<ExcelColumnMapping<Dto>>
                        {
                            new() { ColumnName = "欄位 01", ColumnIndex = columIndex++, ValueFunc = (dto) => dto.Column01 },
                            new() { ColumnName = "欄位 02", ColumnIndex = columIndex++, ValueFunc = (dto) => dto.Column02 },
                            new() { ColumnName = "欄位 03", ColumnIndex = columIndex++, ValueFunc = (dto) => dto.Column03 },
                            new() { ColumnName = "欄位 04", ColumnIndex = columIndex++, ValueFunc = (dto) => dto.Column04 },
                            new() { ColumnName = "欄位 05", ColumnIndex = columIndex++, ValueFunc = (dto) => dto.Column05 },
                        };
    // 寫入標題
    var dtoTitleRow = sheet.CreateRow(rowIndex++);
    foreach (var dtoColumn in dtoColumns)
    {
        dtoTitleRow.CreateCell(dtoColumn.ColumnIndex).SetCellValue(dtoColumn.ColumnName);
    }

    // 寫入資料
    foreach (var dto in dtos)
    {
        var defectValueRow = sheet.CreateRow(rowIndex++);
        foreach (var defectColumn in dtoColumns)
        {
            defectValueRow.CreateCell(defectColumn.ColumnIndex).SetCellValue(defectColumn.ValueFunc.Invoke(dto));
        }

        // 針對第 Column Index 0 處理自動換行
        var cs = workbook.CreateCellStyle();
        cs.WrapText                         = true;
        defectValueRow.GetCell(0).CellStyle = cs;
    }
}

public class ExcelColumnMapping<T>
{
    public string ColumnName { get; set; }

    public int ColumnIndex { get; set; }

    public Func<T, string> ValueFunc { get; set; }
}
```
