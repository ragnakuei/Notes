# [list-style-type](https://developer.mozilla.org/en-US/docs/Web/CSS/list-style-type)

- 指定 項目符號
- 通常用於
    - ol > li
    - ul > li
    - summary


### div

除了 list-style-type: disc 為預設樣式外，其餘的都要自己設定

```html
<style>
  .item {
    display: list-item;
    list-style-position: inside;
    list-style-type: disc;
  }
</style>

<div>
  <div class="item">A</div>
  <div class="item">B</div>
  <div class="item">C</div>
</div>
```