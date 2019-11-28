# bootstrap pagination-動態版

因為呼叫端在建立 Page 頁面時，會先建立 aspx 內的所有控制項，才會進入到 Page_Load() 中

這樣會造成一個矛盾點

1. 必須先給定 pageIndex、pageSize 給`分頁控制項`後，才能建立`分頁控制項`
1. 要讀取完所有資料後，才能建立`分頁控制項`

所以後來改用另一個做法

- 先建立 aspx 頁面，再建立`分頁控制項`
- [在同一個頁面多次加入相同的 UserControl](./在同一個頁面多次加入相同的%20UserControl.md)

---

## 步驟

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

    - 分別建立上方`分頁控制項`及下方`分頁控制項` div 並給定不同的 id upperPagination 及 bottomPagination
    - `分項控制項`都要加上 runat="server"，這樣就可以在 aspx.cs 中讀取

   ```html
   <%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
   AutoEventWireup="false" CodeBehind="List.aspx.cs"
   Inherits="AngularDemoWebForm.Order.List" %>

   <asp:Content
     ID="BodyContent"
     ContentPlaceHolderID="MainContent"
     runat="server"
   >
     <div id="upperPagination" runat="server"></div>
     <asp:GridView> </asp:GridView>
     <div id="bottomPagination" runat="server"></div>
   </asp:Content>
   ```

    ```csharp
   public partial class List : System.Web.UI.Page
   {
       private const int DefaultPageSize = 10;

       /// <summary>
       /// UI 上是 Base 1，資料處理是 Base 0
       /// </summary>
       private int _pageIndex;
       private int _totalCount;
       private int _pageSize;
       private IOrderService _orderService => DiFactory.GetService<IOrderService>();

       protected override void OnPreLoad(EventArgs e)
       {
           base.OnPreLoad(e);

           ExtractQueryString();

           if (!this.IsPostBack)
           {
               if ((orderList.ShowHeader && orderList.Rows.Count > 0)
                || (orderList.ShowHeaderWhenEmpty))
               {
                   orderList.HeaderRow.TableSection = TableRowSection.TableHeader;
               }

               SetOrderListDataSource(_pageIndex, _pageSize);
           }

           var pagination = (BootstrapPagination)Page.LoadControl("~/UserControls/BootstrapPagination.ascx");
           pagination.PageIndex = _pageIndex + 1;
           pagination.TotalCount = _totalCount;
           pagination.PageSize = _pageSize;
           pagination.Positon = "right";
           upperPagination.Controls.Add(pagination);
           bottomPagination.Controls.Add(pagination.DeepClone());  // 動態加入相同的使用者控制項要處理的部份，一定要加 DeepClone 來處理
       }

       private void ExtractQueryString()
       {
           var queryString = Request.QueryString;
           _pageSize = queryString["pageSize"]?.ToInt32() ?? DefaultPageSize;
           _pageIndex = queryString["pageIndex"]?.ToInt32() - 1  ?? 0;
       }

       private void SetOrderListDataSource(int pageIndex, int pageSize)
       {
           var orderListDto = _orderService?.GetOrderListToDataTable(pageIndex, pageSize);

           _totalCount = orderListDto.TotalCount;

           orderList.DataSource = orderListDto.Items;
           orderList.DataBind();
       }

       protected void orderListOnPageIndexChanging(object sender, GridViewPageEventArgs e)
       {
           orderList.PageIndex = e.NewPageIndex;
           SetOrderListDataSource(0, 10);
       }
   }
   ```