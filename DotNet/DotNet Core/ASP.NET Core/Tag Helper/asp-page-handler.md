# [asp-page-handler](https://www.learnrazorpages.com/razor-pages/handler-methods)

- 可以讓一個 View 可以共用相同的 Http Method 及不同的 Method
- 會以 query string 方式顯示

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
