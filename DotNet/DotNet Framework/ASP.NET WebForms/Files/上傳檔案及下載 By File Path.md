# 上傳檔案及下載 By File Path

Response.TransmitFile(file_with_path)

```csharp
protected void btnConvert_Click(object sender, EventArgs e)
{
    if (FileUpload1.HasFiles == false)
    {
        lblMessage.Text = "請上傳檔案";
        return;
    }

    var wordFile = SaveWord(FileUpload1.PostedFile);
    var mergeFields = new Dictionary<string, object>
    {
        ["fullName"] = "Test",
        ["age"] = "18",
        ["address"] = "Address ABC",
        ["myImage"] = File.ReadAllBytes(@"C:\tmp\Annotation 2019-12-06 125354.png")
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

private void ReplaceMergeField(FileInformation wordFile, Dictionary<string, object> mergeFields)
{
    var doc = new Document(wordFile.FileNameWithPath);
    doc.MailMerge.Execute(mergeFields.Keys.ToArray(),
                            mergeFields.Values.ToArray());
    doc.Save(wordFile.FileNameWithPath);
}

```
