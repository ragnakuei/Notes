# 選擇 Row 的事件

```html
<script>
  $("#grid-data-api")
    .bootgrid({
      ajax: true,
      url: "/api/customer",
      selection: true,
      rowSelect: true
    })
    .on("selected.rs.jquery.bootgrid", function(e, rows) {
      var rowIds = [];
      for (var i = 0; i < rows.length; i++) {
        rowIds.push(rows[i].Id);
      }
      alert("Select: " + rowIds.join(","));
    });
</script>
```
