# 產生 Excel 檔

```csharp
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

private void GenerateExcelFromFileInformation(FileInformation fileInformation)
{
    var wb = new Workbook();
    var sheet = wb.Worksheets[0];
    sheet.Name = "SheetA";
    var cell = sheet.Cells["A1"];

    cell.PutValue("Hello World!");

    wb.Save(fileInformation.FileNameWithPath, SaveFormat.Xlsx);
}

private FileInformation GenerateFileInformation()
{
    var result = new FileInformation();
    result.FileName = "Sample.xlsx";
    result.ContentType = MimeMapping.GetMimeMapping(result.FileName);

    var siteRootPath = AppDomain.CurrentDomain.BaseDirectory;
    var filesFolderPath = Path.Combine(siteRootPath, "Files");
    result.FileNameWithPath = Path.Combine(filesFolderPath, result.FileName);

    return result;
}
```
