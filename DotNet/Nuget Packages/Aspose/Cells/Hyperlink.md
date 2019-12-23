# Hyperlink

```csharp
private void GenerateExcelFromFileInformation(FileDTO fileInformation)
{
    var wb = new Workbook();
    var sheet = wb.Worksheets[0];
    sheet.Name = "SheetA";

    var hyperLinkIndex = sheet.Hyperlinks.Add("A1", 1, 1, "https://www.google.com/");
    var hyperLink = sheet.Hyperlinks[hyperLinkIndex];

    // Cell 上的 ToolTip
    hyperLink.ScreenTip = "ScreenTip";

    // HyperLink 上的 Text
    hyperLink.TextToDisplay = "TextToDisplay";

    // 如果未給定 HyperLink Text，就會直接以連結做為 Texg
    sheet.Hyperlinks.Add("A3", 1, 1, "https://tw.yahoo.com");

    wb.Save(fileInformation.FileNameWithPath, SaveFormat.Xlsx);
}
```
