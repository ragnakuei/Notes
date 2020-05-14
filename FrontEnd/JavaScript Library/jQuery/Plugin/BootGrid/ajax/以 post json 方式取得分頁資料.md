# 以 post json 方式取得分頁資料

- 指定 content-type 為 json
- 在 requestHandler 中，產生 request body 為 json 格式的資料

```html
<script>
  try {
    $("#orderList").bootgrid({
      navigation: 3,
      css: {
        pagination: "pagination",
        paginationButton: "page-link"
      },
      templates: {
        search: "",
        pagination: '<ul class="{{css.pagination}}"></ul>',
        paginationItem:
          '<li class="{{ctx.css}}"><a data-page="{{ctx.page}}" class="{{css.paginationButton}}" href="#"><span aria-hidden="true">{{ctx.text}}</span></a></li>'
      },
      ajaxSettings: {
        method: "POST",
        cache: false,
        contentType: "application/json"
      },
      ajax: true,
      url: "/api/order/list",
      requestHandler: function(request) {
        var model = {};
        model.Current = request.current;
        model.RowCount = request.rowCount;
        // model.Search = request.searchPhrase;

        // for (var key in request.sort) {
        //     model.SortBy = key;
        //     model.SortDirection = request.sort[key];
        // }

        return JSON.stringify(model);
      }
    });
  } catch (e) {
    console.log("error occurs");
    console.log(e);
  }
</script>
```
