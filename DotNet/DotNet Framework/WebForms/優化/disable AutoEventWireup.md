# disable AutoEventWireup

```csharp
using AngularDemoWebForm.DI;
using BusinessLogic.Order;
using System;
using System.Web.UI.WebControls;

namespace AngularDemoWebForm.Order
{
    public partial class List : System.Web.UI.Page
    {
        public IOrderService _orderService => DiFactory.GetService<IOrderService>();

        protected int pageIndex;
        protected int totalCount;
        protected int pageSize;

//        protected void Page_Load(object sender, EventArgs e)   // 1
        protected override void OnPreLoad(EventArgs e)
        {
            base.OnPreLoad(e);                                   // 2

            if (!this.IsPostBack)
            {
                pageIndex = 0;
                pageSize = 10;

                if ((orderList.ShowHeader && orderList.Rows.Count > 0)
                 || (orderList.ShowHeaderWhenEmpty))
                {
                    orderList.HeaderRow.TableSection = TableRowSection.TableHeader;
                }

                SetOrderListDataSource(0, orderList.PageSize);
            }
        }
    }
}
```
