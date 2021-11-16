# [ClientIDMode](https://docs.microsoft.com/en-us/dotnet/api/system.web.ui.control.clientidmode)

## Content Page DOM ID 隨機給定

[Control ID Naming in Content Pages](https://docs.microsoft.com/en-us/aspnet/web-forms/overview/older-versions-getting-started/master-pages/control-id-naming-in-content-pages-cs) 提到了 Control ID 的命名方式 !

在 MasterPage 的結構下，為了讓 MasterPage 上的 Server Control ID 不要讓 Content Page 內的 Server Control ID 衝突

所以在 Render Html 後，Content Page 的所有 Server Control ID 都會加上 Master Page ContentPlaceHolder ID

所以導致 jQuery 在處理 DOM ID 上，會比較麻煩

解決方式：  

1. 在 Content Page 中，要讓固定 DOM ID 的 Server Control 都加上 `ClientIDMode="Static"` 就可以了

    範例：

    ```cs
    <asp:HiddenField runat="server" ID="formData" ClientIDMode="Static" />
    ```

1. 直接取出 ClientID

    範例：

    ```html
    <script>
        window.test = <%= formData.ClientID %>
    </script>
    ```
