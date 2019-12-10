# 上傳 Word 檔轉存成 PDF

目前測試，只能先存成檔案，再用檔案的方式回傳

流程

- user 上傳檔案
- 檔案放到 `/Files` 中
- 呼叫 Aspose 進行轉換
- 回傳 pdf 檔

> 如果不指定輸出格式，就會依照副檔名自動判斷輸出格式

```csharp
public partial class ConvertFromWord : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AposeLicenseService.RegisterWords();
    }

    protected void btnConvert_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFiles == false)
        {
            lblMessage.Text = "請上傳檔案";
            return;
        }

        var pdfFile = SaveFromWrodToPdf(FileUpload1.PostedFile, out string wordFilePath);

        Response.ContentType = pdfFile.ContentType;
        Response.AppendHeader("Content-Disposition", $"attachment; filename={pdfFile.FileName}");
        Response.TransmitFile(pdfFile.FileNameWithPath);
        Response.Flush();

        File.Delete(wordFilePath);
        File.Delete(pdfFile.FileNameWithPath);

        Response.End();
    }

    private FileInfo SaveFromWrodToPdf(HttpPostedFile postedFile, out string wordFilePath)
    {
        var result = new FileInfo();
        result.FileName = postedFile.FileName.Replace(".docx", ".pdf");
        result.ContentType = MimeMapping.GetMimeMapping(result.FileName);

        var siteRootPath = AppDomain.CurrentDomain.BaseDirectory;
        var filesFolderPath = Path.Combine(siteRootPath, "Files");
        var filePath = Path.Combine(filesFolderPath, postedFile.FileName);
        postedFile.SaveAs(filePath);

        wordFilePath = Path.Combine(filesFolderPath, postedFile.FileName);

        var doc = new Aspose.Words.Document(filePath);
        result.FileNameWithPath = Path.Combine(filesFolderPath, result.FileName);
        doc.Save(result.FileNameWithPath, Aspose.Words.SaveFormat.Pdf);

        return result;
    }
}

internal class FileInfo
{
    public string ContentType { get; internal set; }
    public Stream FileStream { get; internal set; }
    public string FileName { get; internal set; }
    public string FileNameWithPath { get; internal set; }
}
```

```html
<form id="form1" runat="server">
  <div>
    <p>
      <asp:FileUpload ID="FileUpload1" runat="server" />
    </p>
    <p>
      <asp:Button
        ID="btnConvert"
        runat="server"
        Text="Convert"
        OnClick="btnConvert_Click"
      />
    </p>
    <p>
      <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
    </p>
  </div>
</form>
```

---

TODO：以 Stream 的方式轉換後，再回傳

> 目前 Webform 會下載到空檔案
