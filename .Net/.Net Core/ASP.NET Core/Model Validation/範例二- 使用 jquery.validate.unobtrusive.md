# 範例二- 使用 jquery.validate.unobtrusive

## View 範例

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
