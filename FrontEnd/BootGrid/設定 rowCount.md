# 設定 rowCount

```js
$("#grid-basic").bootgrid({
  selection: true,

  caseSensitive: false,

  rowCount: [20, 40, 60],

  formatters: {
    link: function(column, row) {
      return '<a href="#">' + column.id + ": " + row.id + "</a>";
    }
  }
});
```
