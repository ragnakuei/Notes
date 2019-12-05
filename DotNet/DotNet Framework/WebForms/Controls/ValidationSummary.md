# [ValidationSummary](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols.validationsummary)

用來顯示 Validator 於驗証失敗時的訊息

## RequiredFieldValidator

```html
<form id="form1" runat="server">
  <table>
    <tr>
      <td>
        <label for="username">UserName</label>
      </td>
      <td>
        <asp:TextBox ID="username" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
          ID="user"
          runat="server"
          ControlToValidate="username"
          ErrorMessage="Please enter a user name"
          ForeColor="Red"
          >*</asp:RequiredFieldValidator
        >
      </td>
    </tr>
    <tr>
      <td>
        <label for="password">Password</label>
      </td>
      <td>
        <asp:TextBox ID="password" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator
          ID="pass"
          runat="server"
          ControlToValidate="password"
          ErrorMessage="Please enter a password"
          ForeColor="Red"
          >*</asp:RequiredFieldValidator
        >
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <asp:ValidationSummary
          ID="ValidationSummary1"
          runat="server"
          ForeColor="Red"
        />
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <asp:Button ID="Button1" runat="server" Text="login" />
      </td>
    </tr>
  </table>
</form>
```

![Text](_images/ValidationSummary/001.png)
![Text](_images/ValidationSummary/002.png)

## CompareValidator

## CustomValidator

## RangeValidator

## RegularExpresion

## DynamicValidator
