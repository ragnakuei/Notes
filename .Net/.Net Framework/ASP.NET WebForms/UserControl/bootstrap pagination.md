# bootstrap pagination

1. 建立 使用者控制項 `BootstrapPagination.ascx`

   - public field 就是可以從外部給定資料的成員
   - protected field 就是可以從 aspx 讀取資料的成員

   ```csharp
    public partial class BootstrapPagination : System.Web.UI.UserControl
    {
        public int PageIndex;
        public int PageSize;
        public int TotalCount;
        public string Positon;

        protected int pageCount;
        protected int pageRangeIndex = 3;
        protected int startPageIndex;
        protected int endPageIndex;

        protected void Page_Load(object sender, EventArgs e)
        {
            pageCount = TotalCount / PageSize
                        + (TotalCount % PageSize == 0
                                ? 0
                                : 1
                        );
            startPageIndex = Math.Max(PageIndex - pageRangeIndex, 1);
            endPageIndex = Math.Min(PageIndex + pageRangeIndex, pageCount);
        }

        protected string BuildQueryString(int targetPageIndex)
        {
            var absoluteUri = Request.Url.AbsoluteUri;
            var uriBuilder = new UriBuilder(absoluteUri);
            var queryStrings = HttpUtility.ParseQueryString(uriBuilder.Query);
            queryStrings[nameof(PageIndex)] = targetPageIndex.ToString();
            queryStrings[nameof(PageSize)] = PageSize.ToString();
            uriBuilder.Query = queryStrings.ToString();
            return uriBuilder.ToString();
        }

        public BootstrapPagination DeepClone()
        {
            return this.MemberwiseClone() as BootstrapPagination;
        }
    }
   ```

   ```html
    <%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BootstrapPagination.ascx.cs" Inherits="AngularDemoWebForm.UserControls.BootstrapPagination" %>

    <nav aria-label="Page navigation">
        <ul class="pagination <%: Positon.Equals("right", StringComparison.CurrentCultureIgnoreCase) ? "pull-right" : string.Empty %> ">
            <% if (PageIndex > 1)
            { %>
                <li class="page-item">
                    <a class="page-link" href="<%: BuildQueryString(1) %>">
                        <<
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="<%: BuildQueryString(PageIndex - 1) %>">
                        <
                    </a>
                </li>
            <% } %>

            <% for (var i = startPageIndex ; i <= endPageIndex ; i++)
            { %>
                <li class="page-item <%: (i == PageIndex ? "active" : string.Empty) %>">
                    <a class="page-link"
                    href="<%: BuildQueryString(i) %>">
                        <%: i %>
                    </a>
                </li>
            <% } %>

            <% if (PageIndex < pageCount)
            { %>
                <li class="page-item">
                    <a class="page-link" href="<%: BuildQueryString(PageIndex + 1) %>">
                        >
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="<%: BuildQueryString(pageCount) %>">
                        >>
                    </a>
                </li>
            <% } %>
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
     - 如果要以呼叫端的 variable 傳進 UserControl 要用 `<%# variable %>` 語法

   ```html
   <%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
   AutoEventWireup="true" CodeBehind="List.aspx.cs"
   Inherits="AngularDemoWebForm.Order.List" %>

   <%@ Register
   Src="~/UserControls/BootstrapPagination.ascx" TagName="WebControl"
   TagPrefix="TBootstrapPagination" %>

   <asp:Content
     ID="BodyContent"
     ContentPlaceHolderID="MainContent"
     runat="server"
   >
     <TBootstrapPagination:WebControl
       runat="server"
       pageIndex=<%# pageIndex %>
       totalCount="100"
       pagesize="10"
     />
   </asp:Content>
   ```
