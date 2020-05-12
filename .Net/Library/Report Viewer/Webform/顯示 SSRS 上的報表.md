# 顯示 SSRS 上的報表

1. 假設 SSRS 上的報表位於 `http://laptop-a6c1rq2n/ReportServer/Pages/ReportViewer.aspx?/ReportProject/SalesOrders&rs:Command=Render`

   解析出二個字串

   1. ReportServerUrl - `http://laptop-a6c1rq2n/ReportServer`
   1. ReportPath - `/ReportProject/SalesOrders`

1. 那麼 aspx 內就可以透過以下的語法來顯示該報表

   說明

   1. 註冊 `Microsoft.ReportViewer.WebForms` Assembly
   1. 加入 Script Mangager
   1. 加上 rsweb:reportviewer
   1. attribute processingmode 要設定為 `remote`
   1. 加上 ServerReport
      1. attribute ReportServerUrl 指向 `http://laptop-a6c1rq2n/ReportServer`
      1. attribute ReportPath 設定為 `/ReportProject/SalesOrders`

   ```html
   <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report01.aspx.cs"
   Inherits="RDLC.Report01" %>

   <%@ Register
   assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral,
   PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms"
   tagprefix="rsweb" %>
   <!DOCTYPE html>

   <html xmlns="http://www.w3.org/1999/xhtml">
     <head runat="server">
       <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <title></title>
     </head>
     <body>
       <form id="form1" runat="server">
         <asp:ScriptManager
           ID="ScriptManager1"
           runat="server"
         ></asp:ScriptManager>
         <rsweb:reportviewer
           id="ReportViewer1"
           runat="server"
           processingmode="Remote"
         >
           <ServerReport
             ReportServerUrl="http://laptop-a6c1rq2n/ReportServer"
             ReportPath="/ReportProject/SalesOrders"
           />
         </rsweb:reportviewer>
       </form>
     </body>
   </html>
   ```

---

## 透過 C# 語法給定 Server Report 參數

開啟的報表 URL 同上

```csharp
protected void Page_Load(object sender, EventArgs e)
{
    if(!IsPostBack)
    {
        this.ReportViewer1.ProcessingMode = ProcessingMode.Remote;
        this.ReportViewer1.ServerReport.ReportServerUrl = new Uri("http://laptop-a6c1rq2n/ReportServer");
        this.ReportViewer1.ServerReport.ReportPath = "/ReportProject/Sales Orders";
    }
}
```