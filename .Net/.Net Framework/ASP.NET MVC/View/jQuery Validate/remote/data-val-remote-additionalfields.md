# data-val-remote-additionalfields

前置知識：[data-val-remote-additionalfields](../../../../../FrontEnd/JavaScript%20Library/jQuery%20Validate%20Unobtrusive/data-val-remote-additionalfields.md)

## 情境一

當 remote 中指定了 AdditionalFields 時

```csharp
public class RoleValidateModel
{
    [Remote(action : "ValidateNew"
            , controller : "Roles"
            , AdditionalFields = "Id,__RequestVerificationToken"
            , HttpMethod       = "Post")]
    [Required]
    [DisplayName("名稱")]
    [StringLength(10
                , MinimumLength = 2
                , ErrorMessage  = "{0} 至少要 {2} 字元，不超過 {1} 字元")]
    public string Name { get; set; }
}
```
在 View 中以下面的方式來產生 Html 時

```html
@{
    var newRole = new RoleValidateModel();
}

@Html.EditorFor(model => newRole.Name, new { htmlAttributes = new { @class = "form-control" } })
```

就會產生對應的 html attribute `data-val-remote-additionalfields`

```html
<input
  class="form-control text-box single-line"
  data-val="true"
  data-val-length="名稱 至少要 2 字元，不超過 10 字元"
  data-val-length-max="10"
  data-val-length-min="2"
  data-val-remote="'名稱' is invalid."
  data-val-remote-additionalfields="*.Id,*.__RequestVerificationToken"
  data-val-remote-type="Post"
  data-val-remote-url="/Roles/ValidateNew"
  data-val-required="名稱 欄位是必要項。"
  id="newRole_Name"
  name="newRole.Name"
  type="text"
  value=""
/>
```

---

## 情境二

延續情境一的情況，當在 form 裡面使用了 `@Html.AntiForgeryToken()` 時，會導致 `data-val-remote-additionalfields` 讀取不到 name 為 `__RequestVerificationToken` 的資料

目前想到最簡單的做法就是手動給定 `data-val-remote-additionalfields` 的值，而不透過 remote 的方式給定

```html
@Html.EditorFor(model => newRole.Name
                , new
                    {
                        htmlAttributes = new { 
                                                @class = "form-control"
                                                , data_val_remote_additionalfields = $"*.{nameof(RoleValidateModel.Id)},__RequestVerificationToken" 
                                            }
                    })
```

這個做法的好處

- 可以套用 nameof() 的方式來給定 Property Name，這點比以字串的方式給定 Remote.AdditionalFields() 還要更好 !