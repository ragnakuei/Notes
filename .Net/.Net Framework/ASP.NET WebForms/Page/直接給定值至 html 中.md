# 直接給定值至 html 中

```cs
<a href = "~/Products/products.aspx?pr_tp_sn=<%= Eval("id") %>" ><%= Eval("id") %></a>
```