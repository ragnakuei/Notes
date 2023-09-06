# hover

### 範例 01

hover 的物件保留背景色，其餘物件顯示黑色 !
    - 排除 hover 的語法 `:not(:hover)`

```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<style>
.wrap {
  width: 400px;
  height: 100px;
}

.wrap:hover .item:not(:hover) {
  background-color: black !important;
}

.item {
  width: 100px;
  height: 100px;
}
</style>

<div class="wrap d-flex">
  <div class="item bg-primary"></div>
  <div class="item bg-warning"></div>
  <div class="item bg-danger"></div>
  <div class="item bg-success"></div>
</div>
```