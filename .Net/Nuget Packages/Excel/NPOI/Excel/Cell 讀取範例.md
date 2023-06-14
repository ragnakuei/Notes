# Cell 讀取範例

###

資料格式

|      |     |     |     |
| ---- | --- | --- | --- |
| Name | A   | B   | C   |
| Id   | 1   | 2   | 3   |

語法

```cs
var templateFile = Path.Combine("C:\\temp\\test2.xlsx");
using var templateFileStream = new FileStream(templateFile, FileMode.Open, FileAccess.Read);

var workbook = new XSSFWorkbook(templateFileStream);
var sheet = workbook.GetSheetAt(0);

for (var rowIndex = 0; rowIndex <= sheet.LastRowNum; rowIndex++)
{
	for (var columnIndex = 0; columnIndex < sheet.GetRow(rowIndex).LastCellNum; columnIndex++)
	{
		var cell = sheet.GetRow(rowIndex).Cells[columnIndex];
        switch(cell.CellType)
        {
            case NPOI.SS.UserModel.CellType.Numeric:
                Console.WriteLine($"Column[{columnIndex}] Row[{rowIndex}]: {cell.NumericCellValue}");
                break;
            case NPOI.SS.UserModel.CellType.String:
                Console.WriteLine($"Column[{columnIndex}] Row[{rowIndex}]: {cell.StringCellValue}");
                break;
            case NPOI.SS.UserModel.CellType.Formula:
                Console.WriteLine($"Column[{columnIndex}] Row[{rowIndex}]: {cell.CellFormula}");
                break;
            case NPOI.SS.UserModel.CellType.Blank:
                Console.WriteLine($"Column[{columnIndex}] Row[{rowIndex}]: {cell.CellType}");
                break;
            case NPOI.SS.UserModel.CellType.Boolean:
                Console.WriteLine($"Column[{columnIndex}] Row[{rowIndex}]: {cell.BooleanCellValue}");
                break;
            case NPOI.SS.UserModel.CellType.Error:
                Console.WriteLine($"Column[{columnIndex}] Row[{rowIndex}]: {cell.ErrorCellValue}");
                break;
            default:
                Console.WriteLine($"Column[{columnIndex}] Row[{rowIndex}]: {cell.CellType}");
                break;

        }
	}
}
```
