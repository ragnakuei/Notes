# a

- [a](#a)
  - [asp-page](#asp-page)
  - [asp-route-{value}](#asp-route-value)
  - [asp-all-route-data.md](#asp-all-route-datamd)
  - [asp-page-handler](#asp-page-handler)

---

## [asp-page](https://docs.microsoft.com/zh-tw/aspnet/core/mvc/views/tag-helpers/built-in/anchor-tag-helper)

給定 a 的 href 目的地，通常搭配其他 attribute 一起使用

Razor 語法如下：

```html
<a asp-page="/Attendee" asp-route-attendeeid="10">View Attendee</a>
```

實際產生的 Html 如下：

```html
<a href="/Attendee?attendeeid=10">View Attendee</a>
```

---

## [asp-route-{value}](https://docs.microsoft.com/zh-tw/aspnet/core/mvc/views/tag-helpers/built-in/anchor-tag-helper#asp-page)

- 如果 Route 有設定對應的 Parameter 就會套用該 Route 規則來產生 Route

- 如果 Route 沒有設定對應的 Parameter 就會產生 query string field name 及 value

語法

```html
<a
  class="btn btn-primary"
  asp-page="/order/edit"
  asp-route-id="@Model.Id"
  role="button"
  >Edit</a
>
```

---

## [asp-all-route-data.md](https://docs.microsoft.com/zh-tw/aspnet/core/mvc/views/tag-helpers/built-in/anchor-tag-helper#asp-all-route-data)

可以透過 asp-all-route-data 取用 Dictionary<string, string> 來直接組成 route 及 query string

```html
@{ var Prev = new Dictionary<string, string>
  { { nameof(Model.PageSize), Model.PageSize.ToString() }, {
  nameof(Model.PageNo), (Model.PageNo - 1).ToString() } }; var Next = new
  Dictionary<string, string>
    { { nameof(Model.PageSize), Model.PageSize.ToString() }, {
    nameof(Model.PageNo), (Model.PageNo + 1).ToString() } }; }
    <div class="form-group row">
      <a asp-all-route-data="Prev">@nameof(Prev)</a>
      <a asp-all-route-data="Next">@nameof(Next)</a>
    </div></string,
  ></string,
>
```

```html
<a href="/Sample/Sample04?PageSize=10&PageNo=7">Prev</a>
<a href="/Sample/Sample04?PageSize=10&PageNo=9">Next</a>
```

---

## [asp-page-handler](https://www.learnrazorpages.com/razor-pages/handler-methods)

- 可以讓一個 View 可以共用相同的 Http Method 及不同的 Method
- 會以 query string 方式顯示
- 不確定 MVC 是否可用
- 格式 On-Method-Handler
  - Method 就是指 Http Method
  - Handler 自訂名稱

```html
@page @{ @functions{ public string Message { get; set; } = "Initial Request";
public void OnGet() { } public void OnPost() { Message = "Form Posted"; } public
void OnPostDelete() { Message = "Delete handler fired"; } public void
OnPostEdit(int id) { Message = "Edit handler fired"; } public void
OnPostView(int id) { Message = "View handler fired"; } } }

<div class="row">
  <div class="col-lg-1">
    <form asp-page-handler="edit" method="post">
      <button class="btn btn-default">Edit</button>
    </form>
  </div>
  <div class="col-lg-1">
    <form asp-page-handler="delete" method="post">
      <button class="btn btn-default">Delete</button>
    </form>
  </div>
  <div class="col-lg-1">
    <form asp-page-handler="view" method="post">
      <button class="btn btn-default">View</button>
    </form>
  </div>
</div>
<h3 class="clearfix">@Model.Message</h3>
```
