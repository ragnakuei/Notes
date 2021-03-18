# [Model Validation](https://docs.microsoft.com/zh-tw/aspnet/core/mvc/models/validation)

## jquery.validate.unobtrusive

後端 attribute 的給定，主要是套用至 data-val-xxx 中

要套用 `jquery.validate.unobtrusive` 才能在 `前端` 發揮實際作用

但不會會套用至 input type 為 number 的情境

建議搭配的 css

```css
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
```
