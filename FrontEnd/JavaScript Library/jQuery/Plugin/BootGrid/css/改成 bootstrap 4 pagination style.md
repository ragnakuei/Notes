# 改成 bootstrap 4 pagination style

[完整語法連結](<../ajax/以 post json 方式取得分頁資料.md>)

- 指定 css property

  ```json
  css: {
          pagination: "pagination",
          paginationButton: "page-link"
      },
  ```

- 指定 template property

  ```json
  templates: {
      pagination: '<ul class="{{css.pagination}}"></ul>',
      paginationItem:
          '<li class="{{ctx.css}}"><a data-page="{{ctx.page}}" class="{{css.paginationButton}}" href="#"><span aria-hidden="true">{{ctx.text}}</span></a></li>'
  },
  ```
