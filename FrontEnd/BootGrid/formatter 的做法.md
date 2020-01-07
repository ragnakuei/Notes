# formatter 的做法

在指定欄位上加上 attribute data-formatte 及給定的 名稱

```html
<th data-column-id="label" data-formatter="label">Country</th>
```

formatter 提供二個參數

- column : 就是該 header column 的狀態
- row : 就是包含其他欄位的該筆資料

```js
$("#" + matomo_visitor_location.DomTableId).bootgrid({
  rowCount: [10, 20, 30, 50],

  templates: {
    search: ""
  },

  labels: {
    noResults:
      '<div class="alert alert-warning">' +
      '<%= Utils.EscapeHtml(i18nSvc("Thesaurus", "EmptyHistoryHint")) %>' +
      "</div>"
  },

  formatters: {
    label: function(column, row) {
      console.log(column);

      console.log(row);

      return column + "z";
    }
  }
});
```
