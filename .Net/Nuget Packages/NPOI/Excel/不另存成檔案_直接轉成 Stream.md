# 不另存成檔案\_直接轉成 Stream

```csharp
public class NpoiController : Controller
{
    public ActionResult Excel01()
    {
        var excelFile = GenerateFilDTO();
        GenerateExcel(excelFile);

        var resultStream = new MemoryStream(excelFile.FileByteArray);
        return File(resultStream, excelFile.ContentType, excelFile.FileName);
    }

    private static FileDTO GenerateFilDTO()
    {
        var result = new FileDTO();
        result.FileName = "Sample.xlsx";
        result.ContentType = MimeMapping.GetMimeMapping(result.FileName);

        return result;
    }

    public void GenerateExcel(FileDTO excelDTO)
    {
        var workbook = new XSSFWorkbook();
        XSSFSheet sheet = (XSSFSheet)workbook.CreateSheet("sheet");

        var row = sheet.CreateRow(0);//第一行為欄位名稱
        row.CreateCell(0).SetCellValue("name");
        row.CreateCell(1).SetCellValue("score");

        row = sheet.CreateRow(1);//第二行之後為資料
        row.CreateCell(0).SetCellValue("abey");
        row.CreateCell(1).SetCellValue(86);

        var excelFileStream = new MemoryStream();
        workbook.Write(excelFileStream);
        excelFileStream.Close();

        excelDTO.FileByteArray = excelFileStream.ToArray();
    }

    public class FileDTO
    {
        public string ContentType { get; internal set; }
        public string FileName { get; internal set; }
        public byte[] FileByteArray { get; set; }
    }
}
```
