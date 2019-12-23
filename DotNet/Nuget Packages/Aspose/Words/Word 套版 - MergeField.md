# Word 套版 - MergeField

[MergeField 設定方式](../../../../Tools/Microsoft%20Office/Word/新增%20Merge%20Field.md)

設定好 merge field

```text
姓名：«fullName»
年齡：«age»
```

語法

> 只要有相同的 merge field name 都會一併取代

```csharp
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

    var wordFile = SaveWord(FileUpload1.PostedFile);
    var mergeFields = new Dictionary<string, string>
                     {
                         ["fullName"] = "Test",
                         ["age"] = "18",
                     };
    ReplaceMergeField(wordFile, mergeFields);

    Response.ContentType = wordFile.ContentType;
    Response.AppendHeader("Content-Disposition", $"attachment; filename={wordFile.FileName}");
    Response.TransmitFile(wordFile.FileNameWithPath);
    Response.Flush();

    File.Delete(wordFile.FileNameWithPath);

    Response.End();
}

private FileInformation SaveWord(HttpPostedFile postedFile)
{
    var result = new FileInformation();
    result.FileName = postedFile.FileName;
    result.ContentType = MimeMapping.GetMimeMapping(result.FileName);

    var siteRootPath = AppDomain.CurrentDomain.BaseDirectory;
    var filesFolderPath = Path.Combine(siteRootPath, "Files");
    var filePath = Path.Combine(filesFolderPath, postedFile.FileName);
    result.FileNameWithPath = filePath;

    postedFile.SaveAs(result.FileNameWithPath);
    return result;
}

private void ReplaceMergeField(FileInformation wordFile, Dictionary<string, string> mergeFields)
{
    var doc = new Document(wordFile.FileNameWithPath);
    doc.MailMerge.Execute(mergeFields.Keys.ToArray(),
                          mergeFields.Values.Cast<object>().ToArray());
    doc.Save(wordFile.FileNameWithPath);
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

插入圖片

```text
姓名：<<fullName>>
年齡：<<age>>
<<Image:myImage>>
```

```csharp
var wordFile = SaveWord(FileUpload1.PostedFile);
var mergeFields = new Dictionary<string, object>
{
    ["fullName"] = "Test",
    ["age"] = "18",
    ["address"] = "Address ABC",
    ["myImage"] = File.ReadAllBytes(@"C:\tmp\Annotation 2019-12-06 125354.png")
};
ReplaceMergeField(wordFile, mergeFields);
```
