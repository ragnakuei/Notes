# [Control](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.control)

- ClientID

  取得該控制項的 html id

  ```html
  <body>
    <form id="form1" runat="server">
      <div>
        <asp:Button ID="Button1" runat="server" Text="Button" />
      </div>
    </form>
    <script>
      console.log("<%= Button1.ClientID %>");
    </script>
  </body>
  ```


