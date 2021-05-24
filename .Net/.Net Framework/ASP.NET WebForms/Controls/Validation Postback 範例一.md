# Validation Postback 範例一.md

- 驗証通過後，會顯示 js alert

```html
<%@ Page Language="C#" CodeFile="ConfigCountPerStage.aspx.cs" Inherits="Manage.ConfigCountPerStage" %>

<form runat="server"
      action="ConfigCountPerStage.aspx"
      autocomplete="off"
      method="post">
    <p>
        第一階段 未滿：
        <asp:TextBox runat="server"
                     ID="Step1" /> 人
        <asp:RegularExpressionValidator ID="Step1Validator"
                                        ControlToValidate="Step1"
                                        runat="server"
                                        ErrorMessage="只允許輸入數字"
                                        ForeColor="Red"
                                        ValidationExpression="\d+">
        </asp:RegularExpressionValidator>
    </p>
    <p>
        第二階段 未滿：
        <asp:TextBox runat="server"
                     ID="Step2" /> 人
        <asp:RegularExpressionValidator ID="Step2Validator"
                                        ControlToValidate="Step2"
                                        runat="server"
                                        ErrorMessage="只允許輸入數字"
                                        ForeColor="Red"
                                        ValidationExpression="\d+">
        </asp:RegularExpressionValidator>
    </p>
    <p>
        <asp:Button runat="server"
                    Text="送出" />
    </p>
</form>

```


```csharp
using System;
using System.Web.UI;

namespace Manage
{
    public partial class ConfigCountPerStage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                return;
            }

            // 要先執行這個
            Page.Validate();

            // 才能呼叫這個
            if (Page.IsValid)
            {
                ShowMsg("OK");
            }
        }

        private void ShowMsg(string msg)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Msg", "alert('" + msg + "');", true);
        }
    }
}
```