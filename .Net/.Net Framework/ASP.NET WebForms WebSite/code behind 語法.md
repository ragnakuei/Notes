# code behind 語法

## 範例一

```csharp
using System;
using System.Web.UI;

namespace Manage
{
    public partial class Index : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
```

注意：

-   下面第一行 CodeFile 不要用 CodeBehind !

```html
<%@ Page Language="C#" CodeFile="Index.aspx.cs" Inherits="Manage.Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Title</title>
    </head>
    <body>
        <form id="HtmlForm" runat="server">
            <div></div>
        </form>
    </body>
</html>
```
