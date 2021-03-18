# Master Pages


MasterPage.master

```html
<%@ Master Language="C#" CodeBehind="MasterPage.aspx.cs" Inherits="WebformVue.Master" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
<div>
    <asp:ContentPlaceHolder id="body"
                            runat="server">

    </asp:ContentPlaceHolder>
</div>
<asp:ContentPlaceHolder id="script"
                        runat="server">
</asp:ContentPlaceHolder>
</body>
</html>

```

MasterPage.aspx.cs

```csharp
using System;
using System.Web.UI;

namespace WebformVue
{
    public partial class Master : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
```

Default.aspx

```html
<%@ Page Title="Title" Language="C#" MasterPageFile="~/MasterPage.Master" CodeBehind="Default.aspx.cs" Inherits="WebformVue.Default" %>

<asp:Content ID="Content1"
             ContentPlaceHolderID="body"
             runat="server">
    Body
</asp:Content>
<asp:Content ID="Content2"
             ContentPlaceHolderID="script"
             runat="server">
    Script
</asp:Content>

```


Default.aspx.cs

```csharp
using System;
using System.Web.UI;

namespace WebformVue
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
```
