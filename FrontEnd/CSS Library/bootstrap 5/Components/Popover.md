# Popover

- 可以透過 data-bs 屬性來設定相關的資訊
- 也可以透過 js 初始化相關 attributes
- trigger 條件
  - 常用的有 click | hover | focus 
- title 的 class 為 .popover-header
- content 的 class 為 .popover-body

## 範例 01

```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

<div class="container m-5">
    <span class="d-inline-block" 
          tabindex="0" 
          data-bs-toggle="popover" 
          data-bs-placement="top"
          data-bs-title="Popover title"
          data-bs-custom-class="abc"
          data-bs-trigger="hover" 
          data-bs-content="Disabled popover">
        Show tooltip when hover
    </span>
</div>

<script>
    [...document.querySelectorAll('[data-bs-toggle="popover"]')]
        .map(function(popoverElement) {
        return new bootstrap.Popover(popoverElement, {
            placement: 'bottom',
        })
    });
</script>
```


## 範例 02

```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

<style>
    .custom-container {
    margin: 50px;
    padding: 50px;
    }
</style>

<div class="custom-container">
    <span class="d-inline-block" 
          tabindex="0" 
          data-bs-toggle="popover" 
          data-bs-trigger="hover" 
          data-bs-html='true'
          data-bs-custom-class="abc"
          data-bs-placement='top'
          data-bs-title='title'
          data-bs-content="<sup>sup</sup><sub>sub</sub>">
        Show tooltip when hover
    </span>
</div>

<script>
    [...document.querySelectorAll('[data-bs-toggle="popover"]')]
        .map(function(popoverElement) {
        return new bootstrap.Popover(popoverElement)
    });
</script>
```