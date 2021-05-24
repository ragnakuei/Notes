# 不 code behind 語法

## 範例一

```cs
<%@ Page Language="C#"%>
<%@ OutputCache Location="None" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<script runat="server">
  protected void Page_Load(object sender, EventArgs e)
  {
    var formBody = Request.Form["json"];

    var checkItemDto = JsonConvert.DeserializeObject<CheckItemDto>(formBody);

    Response.ContentType = "application/json";
    Response.Write(JsonConvert.SerializeObject(checkItemDto));
    Response.StatusCode = 200;
    Response.Flush();
    Response.End();
  }
</script>
```