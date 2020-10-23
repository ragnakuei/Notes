# 選取 form 內所有 勾選的 checkbox

```js
var form = $('#postEditForm');

const assignEngineers = form.find('input:checkbox:checked')
                            .map(function (index, checkbox)
                            {
                                return $(checkbox).val();
                            }).toArray();
```