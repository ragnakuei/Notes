# ViewModel Validateion

在 ViewModel 上，以 attribute 的方式宣告驗証條件

就可以在 Model Binding 時，進行驗証

如果有引用 jQuery Validate 相關套件的話，甚至可以直接在前端驗証

---

## 範例：套用至前端 jQuery Validate

- [範例](https://github.com/ragnakuei/AspNetMvcJqueryValidation)

- 前端觸發驗証的條件
  
  第一次進入頁面，會無法直接觸發前端驗証，直到進行以下二個動作時：

  - blur 控制項時
  - 直接 post 至後端

- 安裝套件

  > Install-Package jQuery.Validation.Unobtrusive

- 注意

  > 把 jQuery 相關套件全部升到最新，不然 jQuery validate 功能可能不會正常。

- 程式碼

    ```c#
    public class TestViewModel
    {
        [Required]
        [StringLength(8, ErrorMessage = "{0} length must be between {2} and {1}.", MinimumLength = 6)]
        public string Name { get; set; }
    }

    public class TestController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [ActionName("Index")]
        [ValidateAntiForgeryToken]
        public ActionResult IndexPost(TestViewModel viewModel)
        {
            if(ModelState.IsValid == false)
            {
                TempData["Message"] = "驗証失敗";
                return View(viewModel);
            }

            TempData["Message"] = "驗証成功";
            return RedirectToAction("Index");
        }
    }
    ```

    View

    ```html
    @model  MvcJqueryValidation.Models.TestViewModel
    @{
        ViewBag.Title = "Index";

        var message = TempData["Message"] as string;
    }

    <h2>Index</h2>

    @if (string.IsNullOrWhiteSpace(message) == false)
    {
        <p>驗証結果:@(message)</p>
    }

    @using (Html.BeginForm("Index", "Test", FormMethod.Post))
    {
        @Html.AntiForgeryToken()

        <div class="form-group">
            @Html.LabelFor(model => model.Name, htmlAttributes: new { @class = "control-label col-md-2" })
            <div class="col-md-10">
                @Html.EditorFor(model => model.Name, new { htmlAttributes = new { @class = "form-control" } })
                @Html.ValidationMessageFor(model => model.Name, "", new { @class = "text-danger" })
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <input type="submit" value="Submit" class="btn btn-default" />
            </div>
        </div>
    }


    @section Scripts
    {
        <script src="~/Scripts/jquery.validate.min.js"></script>
        <script src="~/Scripts/jquery.validate.unobtrusive.min.js"></script>
    } 

    ```