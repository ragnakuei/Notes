# 上傳檔案及下載 By Stream

```html
<asp:FileUpload ID="FileUpload1" runat="server" />
```

ContentType 及 Header 給定的順序一定要對 !

```csharp
protected void btn_Click(object sender, EventArgs e)
{
    if (FileUpload1.HasFiles == false)
    {
        lblMessage.Text = "請上傳檔案";
        return;
    }

    Response.ContentType = FileUpload1.PostedFile.ContentType;
    Response.AppendHeader("Content-Disposition", $"attachment; filename={FileUpload1.PostedFile.FileName}");

    // 如果要支援中文檔名，請使用下面的方式
    // Response.AddHeader("Content-Disposition", $"attachment; filename={HttpUtility.UrlEncode(wordFile.FileName, System.Text.Encoding.UTF8)}");

    short bufferSize = 1024;
    byte[] buffer = new byte[bufferSize + 1];
    Response.BufferOutput = false;
    var count = FileUpload1.PostedFile.InputStream.Read(buffer, 0, bufferSize);
    while (count > 0)
    {
        Response.OutputStream.Write(buffer, 0, count);
        count = FileUpload1.PostedFile.InputStream.Read(buffer, 0, bufferSize);
    }
    Response.Flush();
    Response.End();
}
```
