# Excel

目前用 2.4.1 套用 CellStyle 會出現以下錯誤訊息
> Excel completed file-level validation and repair. Some parts of this workbook may have been repaired or rejected. Records repaired: Font from parts /xl/styles.xml (Styles)

```csharp
var font = workbook.CreateFont();
var blueFontStyle = workbook.CreateCellStyle();
font.Color = IndexedColors.Blue.Index;
font.FontHeight = 12;
font.FontName = "微軟正黑體";
blueFontStyle.SetFont(font);
```

解決方式

1. 改用 2.3.0 版
2. 給定 font 完整資料
