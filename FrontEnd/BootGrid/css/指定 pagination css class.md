# 指定 pagination css class

| css              | templates - 對應 {{ctx.xxxx}} |
| ---------------- | ----------------------------- |
| pagination       | css.pagination                |
| paginationButton | css.paginationButton          |

```js
$("#orderList").bootgrid({
  navigation: 3,
  css: {
    pagination: "pagination",
    paginationButton: "button"
  },
  templates: {
    search: "",
    pagination: '<ul class="{{css.pagination}}"></ul>',
    paginationItem:
      '<li class="{{ctx.css}}"> <a data-page="{{ctx.page}}" class="{{css.paginationButton}}"> <span aria-hidden="true">{{ctx.text}}</span> </a> </li>'
  },
  ajaxSettings: {
    method: "POST",
    cache: false
  },
  ajax: true,
  url: "/api/order/list"
});
```
