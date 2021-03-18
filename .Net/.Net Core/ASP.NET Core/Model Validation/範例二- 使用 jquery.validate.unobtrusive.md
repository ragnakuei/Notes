# 範例二- 使用 jquery.validate.unobtrusive

### View 範例一

-   \_ValidationScriptsPartial.cshtml 為範本已提供的 View

```html
@model LoginFormDto

<style>
    .field-validation-error {
        color: #e80c4d;
        font-weight: bold;
    }

    .field-validation-valid {
        display: none;
    }

    input.input-validation-error {
        border: 1px solid #e80c4d;
    }

    .validation-summary-errors {
        color: #e80c4d;
        font-weight: bold;
        font-size: 1.1em;
    }

    .validation-summary-valid {
        display: none;
    }
</style>

<form method="post">
    <p>
        <label asp-for="UserName"></label>
        <input asp-for="UserName" />
        <span asp-validation-for="UserName" class="text-danger"> </span>
    </p>
    <p>
        <label asp-for="Password"></label>
        <input asp-for="Password" />
        <span asp-validation-for="Password" class="text-danger"> </span>
    </p>
    <p>
        <input type="submit" value="Login" />
    </p>
</form>

@section Scripts {
    <partial name="_ValidationScriptsPartial" />
}
```


### View 範例二

[View Render 後的結果](./../../../../FrontEnd/JavaScript%20Library/jQuery%20Validate%20Unobtrusive/jQuery%20Validate%20Unobtrusive.md###%20範例一)
- 支援 regex 驗証


> 註：可以把 \<style> 這一部份宣告，直接放在 _ValidationScriptsPartial.cshtml 中

```html
@model JqueryValidateUnobtrusive01.Controllers.TestViewModel
@{
}
<style>
    .field-validation-error {
        color: #e80c4d;
        font-weight: bold;
    }

    .field-validation-valid {
        display: none;
    }

    input.input-validation-error {
        border: 1px solid #e80c4d;
    }

    .validation-summary-errors {
        color: #e80c4d;
        font-weight: bold;
        font-size: 1.1em;
    }

    .validation-summary-valid {
        display: none;
    }
</style>

<form method="post"
      asp-action="PostIndex">
    <p>
        <label asp-for="Name"></label>
        <input asp-for="Name" />
        <span asp-validation-for="Name"
              class="text-danger">
        </span>
    </p>
    <p>
        <label asp-for="UnitPrice"></label>
        <input asp-for="UnitPrice" />
        <span asp-validation-for="UnitPrice"
              class="text-danger">
        </span>
    </p>
    <p>
        <label asp-for="AssignDate"></label>
        <input asp-for="AssignDate" />
        <span asp-validation-for="AssignDate"
              class="text-danger">
        </span>
    </p>
    <p>
        <input type="submit"
               value="Submit">
    </p>
</form>

@section Scripts {
    <partial name="_ValidationScriptsPartial" />
}
```

```csharp
public class TestViewModel
{
    [Display(Name                                 = "名稱", Prompt = "名稱")]
    [Required(ErrorMessage                        = "請填寫{0}")]
    [StringLength(maximumLength: 5, MinimumLength = 2, ErrorMessage = "{0} 長度要介於 {2} 及 {1} 之間")]
    public string Name { get; set; }

    [Display(Name                                = "單價", Prompt = "單價")]
    [Required(ErrorMessage                       = "請填寫{0}")]
    [Range(minimum: 1, maximum: 10, ErrorMessage = "{0} 要介於 {2} 及 {1} 之間")]
    [RegularExpression("([0-9]+)", ErrorMessage  = "請輸入正整數")]
    public int? UnitPrice { get; set; }

    [Display(Name          = "分配日期", Prompt = "分配日期")]
    [Required(ErrorMessage = "請填寫{0}")]
    [DataType(DataType.Date)]
    public DateTime? AssignDate { get; set; }
}
```