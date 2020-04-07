# ClientIDMode

## Content Page DOM ID 隨機給定

在 MasterPage 的結構下，為了讓 MasterPage 上的 Server Control ID 不要讓 Content Page 內的 Server Control ID 衝突

所以在 Render Html 後，Content Page 的所有 Server Control ID 都會加上 Master Page ContentPlaceHolder ID

所以導致 jQuery 在處理 DOM ID 上，會比較麻煩

解決方式：  

在 Content Page 中，要讓固定 DOM ID 的 Server Control 都加上 `ClientIDMode="Static"` 就可以了

範例：

> <asp:HiddenField runat="server" ID="formData" ClientIDMode="Static" />

