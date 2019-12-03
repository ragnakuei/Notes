# 使用 Parameter 的方式

1. ReportViewer 參考以下語法加上 Parameter

   ```csharp
   var rpCurrMonth = new ReportParameter("displayDate", DateTime.Now.ToString("yyyy-MM-dd"));
   this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rpCurrMonth });
   ```

1. RDLC 操作

   - Visual Studio > 報表資料 Panel > 新增 > 參數
   - 名稱與上面程式碼的 `displayDate` 一致

1. 執行
