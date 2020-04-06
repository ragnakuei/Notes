# 需要引用的 dll

如果未引用該 dll 就會在未安裝 DevExpress 的主機上才會發生找不到 SVG 檔案的問題 !!

> DevExpress.Images


```xml
<dxb:BarButtonItem
    x:Name="New"
    Content="New"
    LargeGlyph="{dx:DXImage 'SvgImages/Spreadsheet/New.svg'}" />
```