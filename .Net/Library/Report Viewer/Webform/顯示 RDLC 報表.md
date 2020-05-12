# 顯示 RDLC 報表

1. 先設計好 `Report01.rdlc` 報表
1. .aspx 加上語法

   說明

   1. 註冊 `Microsoft.ReportViewer.WebForms` Assembly
   1. 加入 Script Mangager
   1. 加上 rsweb:reportviewer

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
         <rsweb:reportviewer id="ReportViewer1" runat="server">
         </rsweb:reportviewer>
       </form>
     </body>
   </html>
   ```

1. .aspx.cs 加上語法

   ```csharp
   using Microsoft.Reporting.WebForms;
   using System;
   using System.Configuration;
   using System.Data;
   using System.Data.SqlClient;
   using System.IO;

   namespace RDLC
   {
       public partial class Report01 : System.Web.UI.Page
       {
           protected void Page_Load(object sender, EventArgs e)
           {
               if (!IsPostBack)
               {
                   SetReportViewer();
               }
           }

           private void SetReportViewer()
           {
               string rptName = "Report01.rdlc";//報表名稱
               this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
               this.ReportViewer1.LocalReport.ReportPath = Path.Combine(Server.MapPath("."), rptName);

               var rpCurrMonth = new ReportParameter("displayDate", DateTime.Now.ToString("yyyy-MM-dd"));
               this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rpCurrMonth });

               this.ReportViewer1.LocalReport.EnableHyperlinks = true;
               this.ReportViewer1.LocalReport.DataSources.Clear();
               var rds1 = new ReportDataSource("DataSet1", GetReportDate());
               this.ReportViewer1.LocalReport.DataSources.Add(rds1);  //綁定數據源
           }

           private DataTable GetReportDate()
           {
               var sql = @"
   select o.OrderID,o.CustomerID, o.EmployeeID, o.OrderDate, c.CompanyName, c.ContactName, od.ProductID, p.ProductName, od.Quantity, od.Discount, od.UnitPrice
   from dbo.Orders o
   left join dbo.[Order Details] od
       on od.OrderID = o.OrderID
   left join dbo.Products p
       on p.ProductID = od.ProductID
   left join dbo.Customers c
       on c.CustomerID = o.CustomerID
   ";
               var queryResult = new DataTable();
               var connectionString = ConfigurationManager.ConnectionStrings["NorthwindConnectionString"]?.ToString();
               using (SqlConnection connection = new SqlConnection(connectionString))
               {
                   var command = new SqlCommand(sql, connection);
                   SqlDataReader dr = null;

                   try
                   {
                       if (connection.State != ConnectionState.Open)
                       {
                           connection.Open();
                       }

                       dr = command.ExecuteReader();
                       queryResult.Load(dr);

                       if (connection.State != ConnectionState.Closed)
                       {
                           connection.Close();
                       }
                   }
                   catch (Exception ex)
                   {
                       if (connection.State != ConnectionState.Closed)
                       {
                           connection.Close();
                       }
                       throw ex;
                   }
               }

               return queryResult;
           }
       }
   }
   ```
