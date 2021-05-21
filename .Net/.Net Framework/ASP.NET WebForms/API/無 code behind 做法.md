# 無 code behind 做法

- 接收到 FormData 後，就可以立即處理 !

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