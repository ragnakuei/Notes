# bootstrap pagination

1. 建立 使用者控制項 `BootstrapPagination.ascx`

   - public field 就是可以從外部給定資料的成員
   - protected field 就是可以從 aspx 讀取資料的成員

   ```csharp
   public partial class BootstrapPagination : System.Web.UI.UserControl
   {
       public int pageIndex;
       public int pageSize;
       public int totalCount;
       protected int pageCount;

       protected void Page_Load(object sender, EventArgs e)
       {
           pageCount = totalCount/pageSize;
       }
   }
   ```

   ```html
   <%@ Control Language="C#" AutoEventWireup="true"
   CodeBehind="BootstrapPagination.ascx.cs"
   Inherits="AngularDemoWebForm.UserControls.BootstrapPagination" %>

   <nav aria-label="Page navigation">
     <ul class="pagination">
       <li class="page-item"><a class="page-link" href="#">First</a></li>
       <li class="page-item"><a class="page-link" href="#">Previous</a></li>

       <% foreach (var i in Enumerable.Range(1, pageCount)) { %>
       <li class="page-item"><a class="page-link" href="#"><%: i %></a></li>
       <% } %>

       <li class="page-item"><a class="page-link" href="#">Next</a></li>
       <li class="page-item"><a class="page-link" href="#">Last</a></li>
     </ul>
   </nav>
   ```

1. 呼叫端

   - 要記得先註冊 User Control

     - Src - User Control 的路徑
     - TagName - 自訂名稱
     - TagPrefix - 自訂名稱

   - 呼叫點

     - 以 <TagPrefix:TagName runat="server" /> 的方式就可以呼叫了
     - User Control 內需要給定的 field 就直接以 attribute 的方式給定即可

   ```html
   <%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
   AutoEventWireup="true" CodeBehind="List.aspx.cs"
   Inherits="AngularDemoWebForm.Order.List" %> <%@ Register
   Src="~/UserControls/BootstrapPagination.ascx" TagName="WebControl"
   TagPrefix="TBootstrapPagination" %>

   <asp:Content
     ID="BodyContent"
     ContentPlaceHolderID="MainContent"
     runat="server"
   >
     <TBootstrapPagination:WebControl
       runat="server"
       pageIndex="2"
       totalCount="100"
       pagesize="10"
     />
   </asp:Content>
   ```
