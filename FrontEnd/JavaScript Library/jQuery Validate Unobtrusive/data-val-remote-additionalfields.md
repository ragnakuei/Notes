# data-val-remote-additionalfields

這個 attribute 的用意是為了讓 jQuery validate 能多夾帶一些 property fields

範例

```html
<input data-val-remote-additionalfields="__RequestVerificationToken" />
<input data-val-remote-additionalfields="*.Name,__RequestVerificationToken" />
<input data-val-remote-additionalfields="*.Id,*.Name,__RequestVerificationToken" />
```
