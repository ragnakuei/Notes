# Tooltip

- 可以透過 data-bs 屬性來設定相關的資訊
- 也可以透過 js 初始化相關 attributes

## 範例 01

```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

<div class="container m-5">    
    <button type="button" 
            class="btn btn-secondary" 
            data-bs-toggle="tooltip" 
            data-bs-html="true" 
            title="<em>Tooltip</em> <u>with</u> <b>HTML</b>">
        Tooltip with HTML
    </button>
</div>

<script>    
[...document.querySelectorAll('[data-bs-toggle="tooltip"]')]
            .map(function (popoverElement) {
                return new bootstrap.Tooltip(popoverElement, {
                    placement: 'bottom'
                })
            });
</script>
    
```