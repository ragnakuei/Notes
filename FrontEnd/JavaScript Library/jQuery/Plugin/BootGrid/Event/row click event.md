# row click event

```js
$("#" + matomo_visitor_location.DomTableId)
  .bootgrid({
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
        return (
          ' <img class="displayIcon" src="https://asiannet.innocraft.cloud/' +
          row.logo +
          '">' +
          " <span> " +
          row.label +
          "</span>"
        );
      }
    }
  })
  .on("click.rs.jquery.bootgrid", function(e, cols, row, target) {
    console.log(row);
  });
```
