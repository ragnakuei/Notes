# 從 array 給定資料，並設定

要先設定，再給資料，否則會有問題

```js
$("#" + matomo_visitor_location.DomTableId).bootgrid({
  rowCount: [10, 20, 30, 50],

  templates: {
    search: ""
  },

  converters: {
    nb_visits: {
      from: function(value) {
        return moment(value);
      },

      to: function(value) {
        return value + "z";
      }
    }
  }
});

$("#" + matomo_visitor_location.DomTableId).bootgrid("append", result);
```
