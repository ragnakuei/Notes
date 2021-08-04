# no code-behind 範例

```html
<%@ Control Language="C#"
AutoEventWireup="false"
%>

<script language="c#"
        runat="server">
    public void Page_Load(object sender, EventArgs e)
    {
    }
</script>

<style>
    [v-cloak] {
        display: none;
    }
</style>
```