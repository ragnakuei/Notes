# Picture

```csharp
private void GenerateExcelFromFileInformation(FileDTO fileInformation)
{
    var wb = new Workbook();
    var sheet = wb.Worksheets[0];

    var pictureIndex = sheet.Pictures.Add(1, 1, @"C:\tmp\001.png");
    var picture = sheet.Pictures[pictureIndex];

    pictureIndex = sheet.Pictures.Add(2, 1, @"C:\tmp\002.png");

    wb.Save(fileInformation.FileNameWithPath, SaveFormat.Xlsx);
}
```
