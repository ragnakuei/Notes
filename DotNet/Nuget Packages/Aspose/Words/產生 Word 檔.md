# 產生 Word 檔

## 寫入文字

```csharp
protected void Page_Load(object sender, EventArgs e)
{
    AposeLicenseService.RegisterWords();
}

protected void btnConvert_Click(object sender, EventArgs e)
{
    var wordFile = GenerateFile();
    GenerateWord(wordFile);

    Response.ContentType = wordFile.ContentType;
    Response.AppendHeader("Content-Disposition", $"attachment; filename={wordFile.FileName}");
    Response.TransmitFile(wordFile.FileNameWithPath);
    Response.Flush();

    File.Delete(wordFile.FileNameWithPath);

    Response.End();
}

private FileInformation GenerateFile()
{
    var result = new FileInformation();
    result.FileName = "Test.docx";
    result.ContentType = MimeMapping.GetMimeMapping(result.FileName);

    var siteRootPath = AppDomain.CurrentDomain.BaseDirectory;
    var filesFolderPath = Path.Combine(siteRootPath, "Files");
    var filePath = Path.Combine(filesFolderPath, result.FileName);
    result.FileNameWithPath = filePath;

    return result;
}

private void GenerateWord(FileInformation fileInfo)
{
    var wordDoc = new Document();
    var builder = new DocumentBuilder(wordDoc);

    builder.Writeln("Test1");
    builder.Writeln("Test2");
    builder.InsertImage(@"C:\tmp\Annotation 2019-12-06 125354.png");

    wordDoc.Save(fileInfo.FileNameWithPath);
}
```

---

## 產生 Table

- 基本

  由左至右，由上至下

  除下面同名 Method 外，其餘程式碼與 [寫入文字](##寫入文字) 相同

  ```csharp
  private void GenerateWord(FileInformation fileInfo)
  {
      var wordDoc = new Document();
      var builder = new DocumentBuilder(wordDoc);
      var wordTable = builder.StartTable();
      builder.InsertCell();
      builder.Write("A1");
      builder.InsertCell();
      builder.Write("A2");
      builder.EndRow();

      builder.InsertCell();
      builder.Write("B1");
      builder.InsertCell();
      builder.Write("B2");
      builder.EndRow();

      builder.EndTable();

      wordTable.AutoFit(AutoFitBehavior.AutoFitToContents);

      wordDoc.Save(fileInfo.FileNameWithPath);
  }
  ```

  結果如下圖

  ![Text](_images/產生%20Word%20檔/001.png)

  AutoFitBehavior

  | 選項              | 說明             |
  | ----------------- | ---------------- |
  | AutoFitToWindow   | 預設值，寬度全滿 |
  | AutoFitToContents | 調整成內容寬度   |
  | FixedColumnWidths | 調塑成固定寬度   |

- 單一筆資料設定欄寬的方式

  InsertCell() 會回傳 Cell instance

  就可以透過 Cell.CellFormat.PreferredWidth 來設定欄寬

  > 如果第二筆資料未指定欄寬，那第一列設定的欄寬就會沒用 !

  | PreferredWidth 選項 | 說明         |
  | ------------------- | ------------ |
  | FromPercent         | 設定比例     |
  | FromPoints          | 尚未確認功能 |

  > FromPercent 是把所有欄位的值加總後，再依照該欄位的數值除以總值，才得到比例。

  ```csharp
  builder.InsertCell().CellFormat.PreferredWidth = PreferredWidth.FromPercent(10);
  builder.Write("A1");
  builder.InsertCell().CellFormat.PreferredWidth = PreferredWidth.FromPercent(20);
  builder.Write("A2");
  builder.EndRow();
  ```
