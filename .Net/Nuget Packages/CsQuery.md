# CsQuery

提供類似 jQuery Selector 的功能來幫忙定位 html 內的指定的位置

可以`解析`，也可以`取代` !

```csharp
var cq = new CsQuery.CQ(@"<div class=""toc""><ul class=""content_list"">
    <li><a href=""..."">Chapter 1</a></li>
    <li><a href=""..."">Chapter 2</a></li>
    <li><a href=""..."">Chapter 3</a></li>
</ul></div>");

cq[".toc > .content_list > li > a"]
    .Select(x => x.Cq())
    .ToList().ForEach(x => x.ReplaceWith(x.Text()));
//or with a span wrapper
//.ToList().ForEach(x => x.ReplaceWith(new CsQuery.CQ("<span/>").Text(x.Text())));

cq.Html().Dump();
```