# jQuery Validate Unobtrusive

- [使用jQuery.validate.unobtrusive.js](https://blog.darkthread.net/blog/unobtrusive-jquery-validation/)
- 預設會將驗証失敗的項目帶到畫面正中央 
- 支援 regex 驗証
- 一定要搭配 jQuery.Validate

## 手動註冊指定的 form - 搭配 ajax

```js
$.validator.unobtrusive.parse('#form');
```


## 手動呼叫驗証

```js
// 單一驗証 - 指定 id 為 Name 的 dom 進行驗証 !
$('#form').validate().element("#Name");

// 整個 form 驗証
$("#form").valid();
```

### 範例一

[範例來源](./../../../.Net/.Net%20Core/ASP.NET%20Core/Model%20Validation/範例二-%20使用%20jquery.validate.unobtrusive.md###%20View%20範例二)

```html
<form method="post" action="/Home/PostIndex" novalidate="novalidate">
    <p>
        <label for="Name">名稱</label>
        <input type="text"
               data-val="true"

               @* jquery.validate.unobtrusive - 長度限制 *@
               data-val-length="名稱 長度要介於 2 及 5 之間"
               data-val-length-max="5"
               data-val-length-min="2"

               @* jquery.validate.unobtrusive - 必填限制 *@
               data-val-required="請填寫名稱"
               id="Name"

               @*直接卡住控制項無法輸入超過 5 個字元*@
               maxlength="5"

               name="Name"
               placeholder="名稱"
               value="">
        <span class="text-danger field-validation-valid"
              data-valmsg-for="Name"
              data-valmsg-replace="true">
        </span>
    </p>
    <p>
        <label for="UnitPrice">單價</label>
        <input type="number"
               data-val="true"

               @* jquery.validate.unobtrusive - 範圍限制 *@
               data-val-range="單價 要介於 10 及 1 之間"
               data-val-range-max="10"
               data-val-range-min="1"

               @* jquery.validate.unobtrusive - 必填限制 *@
               data-val-required="請填寫單價"

               @* jquery.validate.unobtrusive - regex 限制 *@
               data-val-regex="Please enter valid Number"
               data-val-regex-pattern="([0-9]+)"

               id="UnitPrice"
               name="UnitPrice"
               placeholder="單價"
               value="">
        <span class="text-danger field-validation-valid"
              data-valmsg-for="UnitPrice"
              data-valmsg-replace="true">
        </span>
    </p>
    <p>
        <label for="AssignDate">分配日期</label>
        <input type="date"
               data-val="true"
               data-val-required="請填寫分配日期"
               id="AssignDate"
               name="AssignDate"
               value=""
               class="valid"
               aria-describedby="AssignDate-error"
               aria-invalid="false">
        <span class="text-danger field-validation-valid"
              data-valmsg-for="AssignDate"
              data-valmsg-replace="true">
        </span>
    </p>
    <p>
        <input type="submit" value="Submit" />
    </p>
</form>
```
