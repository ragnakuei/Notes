# 把 Json Property 改成 小寫開頭

```csharp
var json = JsonConvert.SerializeObject(new
{
    pageInfo.Current,
    pageInfo.RowCount,
    total = orderList.TotalCount,
    rows = orderList.Items,
}, new JsonSerializerSettings
{
    // 把 Json Property 改成 小寫開頭 (CamelCase)
    ContractResolver = new DefaultContractResolver { NamingStrategy = new CamelCaseNamingStrategy() }
});
```