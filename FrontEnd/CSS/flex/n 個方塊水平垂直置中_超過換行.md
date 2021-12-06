# n 個方塊水平垂直置中 超過換行


```html
<div class="container">
    <div class="box"></div>
    <div class="box"></div>
    <div class="box"></div>
    <div class="box"></div>
    <div class="box"></div>
    <div class="box"></div>
    <div class="box"></div>
    <div class="box"></div>
</div>
```

```sass
@mixin size($w, $h : $w)
    width: $w
    height: $h

.container
    +size(50%, 500px)
    background : #cccccc
    display: flex
    flex-direction: row
    flex-wrap: wrap

    <!-- 垂直直中 -->
    align-content: center

    <!-- 左右置中 -->
    justify-content: center
    
.box
    +size(50px)
    background: #00007f
    margin: 10px
    margin-top: 10px
```