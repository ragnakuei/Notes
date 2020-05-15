# ComboBox

Combobox 需要細部微調才能在一開啟 Excel 時，能符合 Cell 的大小，而不像 []() 的做法，是直接嵌在 Cell 上

```csharp
 protected void Page_Load(object sender, EventArgs e)
{
    AposeLicenseService.RegisterExcel();
}

protected void btnDownload_Click(object sender, EventArgs e)
{
    var fileInformation = GenerateFileInformation();
    GenerateExcelFromFileInformation(fileInformation);

    Response.ContentType = fileInformation.ContentType;
    Response.AppendHeader("Content-Disposition", $"attachment; filename={fileInformation.FileName}");
    Response.TransmitFile(fileInformation.FileNameWithPath);
    Response.Flush();
    File.Delete(fileInformation.FileNameWithPath);

    Response.End();
}

private FileDTO GenerateFileInformation()
{
    var result = new FileDTO();
    result.FileName = "Sample.xlsx";
    result.ContentType = MimeMapping.GetMimeMapping(result.FileName);

    var siteRootPath = AppDomain.CurrentDomain.BaseDirectory;
    var filesFolderPath = Path.Combine(siteRootPath, "Files");
    result.FileNameWithPath = Path.Combine(filesFolderPath, result.FileName);

    return result;
}

private void GenerateExcelFromFileInformation(FileDTO fileInformation)
{
    var wb = new Workbook();
    var sheet1 = wb.Worksheets[0];
    sheet1.Name = "SheetA";

    var sheet2Index = wb.Worksheets.Add();
    var sheet2 = wb.Worksheets[sheet2Index];
    sheet2.Name = "ListSource";

    var cells = sheet2.Cells;
    cells["A2"].PutValue("Emp001");
    cells["A3"].PutValue("Emp002");
    cells["A4"].PutValue("Emp003");
    cells["A5"].PutValue("Emp004");
    cells["A6"].PutValue("Emp005");
    cells["A7"].PutValue("Emp006");

    var comboBox = sheet1.Shapes.AddComboBox(1, 0, 2, 0, 22, 100);
    comboBox.LinkedCell = "A1";
    comboBox.InputRange = $"{sheet2.Name}!A2: A7";
    comboBox.DropDownLines = 5;
    comboBox.Shadow = true;

    wb.Save(fileInformation.FileNameWithPath, SaveFormat.Xlsx);
}
```
