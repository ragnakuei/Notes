# overlay 置中

- 會顯示在畫面正中間

```html
<style>
  .overlay {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    background: #666666;
    opacity: .8;
    z-index: 1000;
  }

</style>

<div class="overlay">
  Overlaysdfds
  line2sdf sdfdsf sdfsdf sfdsdf
  <p>line 3</p>
</div>
```
