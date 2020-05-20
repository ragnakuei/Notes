# 範例二：套用 remote 做法

Remote Attribute

| property name     | 說明                                      |
| ----------------- | ----------------------------------------- |
| controller        | 遠端 api 的 controller name               |
| action            | 遠端 api 的 action name                   |
| AddictionalFields | 要傳回的欄位，可以不是 ViewModel 內的項目 |
| HttpMethod        |                                           |
|                   |                                           |

### ViewModel

增加回傳欄位 `__RequestVerificationToken` 就可以支援 antifogery 的驗証了 !

```csharp
public class TestViewModel
{
    public int Id { get; set; }

    [Remote(action : "AjaxValidationName"
          , controller : "Test"
          , AdditionalFields = "Id,__RequestVerificationToken"
          , HttpMethod = "Post")]
    [Required]
    [DisplayName("名稱")]
    [StringLength(10
                , MinimumLength = 2
                , ErrorMessage  = "{0} 至少要 {2} 字元，不超過 {1} 字元")]
    public string Name { get; set; }
}
```

### Controller

測試用的驗証條件，只要包含 a 就回傳 error test

```csharp
public class TestController : Controller
{
    [HttpGet]
    public ActionResult Index()
    {
        var viewMode = new TestViewModel();
        return View(viewMode);
    }

    [HttpPost]
    [ActionName("Index")]
    [ValidateAntiForgeryToken]
    public ActionResult PostIndex(TestViewModel viewModel)
    {
        return View("~/Views/Test/Index.cshtml", viewModel);
    }
    
    [HttpPost]
    [ValidateAntiForgeryToken]
    public ActionResult AjaxValidationName(TestViewModel viewModel)
    {
        if (viewModel.Name.Contains("a"))
        {
            return Json("error test");
        }
        else
        {
            return Json(true);
        }
    }
}
```

### View

為避免為 keyup 一個字元，就進行 remote 驗証，所以 `設定為不在 onkeyup 就立即驗証` !

```html
@model RemoteValidation.Controllers.TestViewModel

@{
    ViewBag.Title = "title";
}

<h2>title</h2>

@using (Html.BeginForm("Index", "Test", FormMethod.Post))
{
    @Html.AntiForgeryToken()

    <div class="form-group">
        @Html.LabelFor(model => model.Name, htmlAttributes : new { @class = "control-label col-md-2" })
        <div class="col-md-10">
            @Html.EditorFor(model => model.Name, new { htmlAttributes = new { @class = "form-control" } })
            @Html.ValidationMessageFor(model => model.Name, "", new { @class = "text-danger" })
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-offset-2 col-md-10">
            <input type="submit" value="Submit" class="btn btn-default"/>
        </div>
    </div>
}

@section scripts
{
    @* 如果有設定 Bundle 可以用以下的語法 *@
    @Scripts.Render("~/bundles/jqueryval")
    
    <script>
        $.validator.setDefaults({
           // 設定為不在 onkeyup 就立即驗証
           onkeyup: false
        })
    </script>
}
```

remote 欄位的 html 會是這樣的

```html
<input
  class="form-control text-box single-line input-validation-error"
  data-val="true"
  data-val-length="名稱 至少要 2 字元，不超過 10 字元"
  data-val-length-max="10"
  data-val-length-min="2"
  data-val-remote="'名稱' is invalid."
  data-val-remote-additionalfields="*.Name,*.Id,*.__RequestVerificationToken"
  data-val-remote-type="Post"
  data-val-remote-url="/Test/AjaxValidationName"
  data-val-required="名稱 欄位是必要項。"
  id="Name"
  name="Name"
  type="text"
  value=""
  aria-invalid="true"
  aria-describedby="Name-error"
/>
```