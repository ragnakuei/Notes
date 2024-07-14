# 另存成檔案\_再轉成 Stream

```csharp
    public class NpoiController : Controller
    {
        public ActionResult Excel01()
        {
            var excelFile = GenerateFilDTO();
            GenerateExcel(excelFile);

            var fileStream = System.IO.File.OpenRead(excelFile.FileNameWithPath);

            return File(fileStream, excelFile.ContentType, excelFile.FileName);
        }

        private static FileDTO GenerateFilDTO()
        {
            var result = new FileDTO();
            result.FileName = "Sample.xlsx";
            result.ContentType = MimeMapping.GetMimeMapping(result.FileName);

            var siteRootPath = AppDomain.CurrentDomain.BaseDirectory;
            var filesFolderPath = Path.Combine(siteRootPath, "Files");
            result.FileNameWithPath = Path.Combine(filesFolderPath, result.FileName);
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
            row.CreateCell(1).SetCellValue(85);

            var fileStream = System.IO.File.Create(excelDTO.FileNameWithPath);
            workbook.Write(fileStream);
            fileStream.Close();
        }

        public class FileDTO
        {
            public long FileStreamLength;
            public string ContentType { get; internal set; }
            public Stream FileStream { get; internal set; } = new MemoryStream();
            public string FileName { get; internal set; }
            public string FileNameWithPath { get; internal set; }
        }
    }
```
