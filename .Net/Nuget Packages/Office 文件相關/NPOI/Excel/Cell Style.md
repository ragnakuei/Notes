# Cell Style

以下範例以 .xlsx 為主

註 1：

> 當設定 Row Style 後，再 CreateCell(i) 時，就會覆蓋掉原本 Row Style !
> 簡單說，Cell Style > Row Style

註 2：

> 建立 CellStyle 最好明確指定型別 XSSFCellStyle

註 3：
> 不同 CellStyle 可以共用，但是要小心以 reference type 的方式給定，只要修改其中一個，其他 reference 相同的 CellStle 也會同時變更 !
> 替代方案：每次給定 CellStyel 時，都透過 method 來建立 CellStyle Instance 即可 !

### 範例

```cs
var rowIndex = 0;

//設定欄寬
sheet.SetColumnWidth(0,  16 * 256);
sheet.SetColumnWidth(1,  16 * 256);
sheet.SetColumnWidth(2,  24 * 256);
sheet.SetColumnWidth(3,  32 * 256);
sheet.SetColumnWidth(4,  32 * 256);
sheet.SetColumnWidth(5,  20 * 256);
sheet.SetColumnWidth(6,  12 * 256);
sheet.SetColumnWidth(7,  12 * 256);
sheet.SetColumnWidth(8,  20 * 256);
sheet.SetColumnWidth(9,  20 * 256);
sheet.SetColumnWidth(10, 12 * 256);

#region Header

// 設定 row0 / row1 底色為 #DCEDF3 & 粗體字 & 欄位置中 & 全框線
var titleStyle = (XSSFCellStyle)sheet.Workbook.CreateCellStyle();
titleStyle.Alignment         = HorizontalAlignment.Center;
titleStyle.VerticalAlignment = VerticalAlignment.Center;
titleStyle.BorderLeft        = BorderStyle.Thin;
titleStyle.BorderTop         = BorderStyle.Thin;
titleStyle.BorderRight       = BorderStyle.Thin;
titleStyle.BorderBottom      = BorderStyle.Thin;
titleStyle.WrapText          = true;

var backGroundColor = new XSSFColor(new byte[] { 220, 237, 243 });
titleStyle.SetFillForegroundColor(backGroundColor);
titleStyle.FillPattern = FillPattern.SolidForeground;

// 設定 row0 / row1 字體為 粗體字
var font = sheet.Workbook.CreateFont();
font.Boldweight = (short)FontBoldWeight.Bold;

IFont titleFont = sheet.Workbook.CreateFont();
titleFont.IsBold = true;
titleStyle.SetFont(titleFont);

// create 2 rows
var row0 = sheet.CreateRow(rowIndex++);
row0.HeightInPoints = 30;

var row1 = sheet.CreateRow(rowIndex++);
row1.HeightInPoints = 30;

// merge A0~A1
sheet.AddMergedRegion(new CellRangeAddress(0, 1, 0, 0));
var cell = row0.CreateCell(0);
cell.SetCellValue("Column01");
cell.CellStyle = titleStyle;

// merge B0~B1
cell           = row1.CreateCell(1);
cell.CellStyle = titleStyle;
sheet.AddMergedRegion(new CellRangeAddress(0, 1, 1, 1));
cell = row0.CreateCell(1);
cell.SetCellValue("Column02");
cell.CellStyle = titleStyle;

cell = row0.CreateCell(2);
cell.SetCellValue("Column03-Upper");
cell.CellStyle = titleStyle;

cell = row1.CreateCell(2);
cell.SetCellValue("Column03-Lower");
cell.CellStyle = titleStyle;

// merge D0~E0
sheet.AddMergedRegion(new CellRangeAddress(0, 0, 3, 4));
cell = row0.CreateCell(3);
cell.SetCellValue("Column04-MergedCells");
cell.CellStyle = titleStyle;
cell           = row1.CreateCell(3);
cell.SetCellValue("Column04-Left");
cell.CellStyle = titleStyle;

cell = row1.CreateCell(4);
cell.SetCellValue("Column05-Right");
cell.CellStyle = titleStyle;

// merge F0~F1
cell           = row1.CreateCell(5);
cell.CellStyle = titleStyle;
sheet.AddMergedRegion(new CellRangeAddress(0, 1, 5, 5));
cell = row0.CreateCell(5);
cell.SetCellValue("Column06");
cell.CellStyle = titleStyle;

// merge G0~G1
cell           = row1.CreateCell(6);
cell.CellStyle = titleStyle;
sheet.AddMergedRegion(new CellRangeAddress(0, 1, 6, 6));
cell = row0.CreateCell(6);
cell.SetCellValue("Column07");
cell.CellStyle = titleStyle;

// merge H0~H1
cell           = row1.CreateCell(7);
cell.CellStyle = titleStyle;
sheet.AddMergedRegion(new CellRangeAddress(0, 1, 7, 7));
cell = row0.CreateCell(7);
cell.SetCellValue("Column08");
cell.CellStyle = titleStyle;

// merge I0~I1
cell           = row1.CreateCell(8);
cell.CellStyle = titleStyle;
sheet.AddMergedRegion(new CellRangeAddress(0, 1, 8, 8));
cell = row0.CreateCell(8);
cell.SetCellValue("Column09");
cell.CellStyle = titleStyle;

// merge J0~J1
cell           = row1.CreateCell(9);
cell.CellStyle = titleStyle;
sheet.AddMergedRegion(new CellRangeAddress(0, 1, 9, 9));
cell = row0.CreateCell(9);
cell.SetCellValue("Column10");
cell.CellStyle = titleStyle;

// merge K0~K1
cell           = row1.CreateCell(10);
cell.CellStyle = titleStyle;
sheet.AddMergedRegion(new CellRangeAddress(0, 1, 10, 10));
cell = row0.CreateCell(10);
cell.SetCellValue("Column11");
cell.CellStyle = titleStyle;

#endregion

// 每個 cell 都要設定全框線
var cellStyle = (XSSFCellStyle)sheet.Workbook.CreateCellStyle();
cellStyle.BorderLeft   = BorderStyle.Thin;
cellStyle.BorderRight  = BorderStyle.Thin;
cellStyle.BorderTop    = BorderStyle.Thin;
cellStyle.BorderBottom = BorderStyle.Thin;

for (var vi = 0; vi < dto.Length; vi++)
{
    var verGroup    = dto[vi];
    var verRowIndex = rowIndex;

    for (var gi = 0; gi < verGroup.Group.Length; gi++)
    {
        var group         = verGroup.Group[gi];
        var groupRowIndex = rowIndex;

        for (var ii = 0; ii < group.Item.Length; ii++)
        {
            var item = group.Item[ii];

            var row = sheet.CreateRow(rowIndex++);

            cell = row.CreateCell(0);
            cell.SetCellValue(item.Column01);
            cell.CellStyle = cellStyle;

            cell = row.CreateCell(1);
            cell.SetCellValue(item.Column02);
            cell.CellStyle = cellStyle;

            cell = row.CreateCell(2);
            cell.SetCellValue(item.Column03);
            cell.CellStyle = cellStyle;

            cell = row.CreateCell(3);
            cell.SetCellValue(item.Column04);
            cell.CellStyle = cellStyle;

            cell = row.CreateCell(4);
            cell.SetCellValue(item.Column05);
            cell.CellStyle = cellStyle;

            cell = row.CreateCell(5);
            cell.SetCellValue(item.Column06);
            cell.CellStyle = cellStyle;


            cell = row.CreateCell(6);
            cell.SetCellValue(item.Column07);
            cell.CellStyle = cellStyle;


            cell = row.CreateCell(7);
            cell.SetCellValue(item.Column08);
            cell.CellStyle = cellStyle;

            cell = row.CreateCell(8);
            cell.SetCellValue(item.Column09);
            cell.CellStyle = cellStyle;

            cell = row.CreateCell(9);
            cell.SetCellValue(item.Column10);
            cell.CellStyle = cellStyle;

            cell = row.CreateCell(10);
            cell.SetCellValue(item.Column11);
            cell.CellStyle = cellStyle;
        }

        // B / C 做 Group RowSpan & Merge 的首個 Cell 要垂直置中
        var groupRowSpan = group.RowSpan;
        if (groupRowSpan > 1)
        {
            sheet.AddMergedRegion(new CellRangeAddress(groupRowIndex, groupRowIndex + groupRowSpan - 1, 1, 1));
            sheet.GetRow(groupRowIndex).Cells[1].CellStyle.VerticalAlignment = VerticalAlignment.Center;

            sheet.AddMergedRegion(new CellRangeAddress(groupRowIndex, groupRowIndex + groupRowSpan - 1, 2, 2));
            sheet.GetRow(groupRowIndex).Cells[2].CellStyle.VerticalAlignment = VerticalAlignment.Center;
        }
    }

    // A 做 Ver RowSpan & Merge 的 Cell 要置中
    var verRowSpan = verGroup.RowSpan;
    if (verRowSpan > 1)
    {
        sheet.AddMergedRegion(new CellRangeAddress(verRowIndex, verRowIndex + verRowSpan - 1, 0, 0));
        sheet.GetRow(verRowIndex).Cells[0].CellStyle.Alignment         = HorizontalAlignment.Center;
        sheet.GetRow(verRowIndex).Cells[0].CellStyle.VerticalAlignment = VerticalAlignment.Center;
    }
}
```
