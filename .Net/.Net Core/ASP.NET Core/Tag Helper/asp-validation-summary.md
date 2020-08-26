# asp-validation-summary

[Model Validation](../Model%20Validation/Model%20Validation.md)

## 語法

放在 form 裡面，才可以套用 `jquery.validate.unobtrusive` 前端驗証的部份

```csharp
<form method="post">
    <div asp-validation-summary="All"></div>

    <p>
        <label asp-for="UserName"></label>
        <input asp-for="UserName" />
        <span asp-validation-for="UserName"
              class="text-danger">
        </span>
    </p>
    <p>
        <label asp-for="Password"></label>
        <input asp-for="Password"
               autocomplete="off" />
        <span asp-validation-for="Password"
              class="text-danger">
        </span>
    </p>
    <p>
        <input type="submit"
               value="Login" />
    </p>
</form>
```
