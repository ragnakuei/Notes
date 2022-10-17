# 手動 trigger Event

```js
let resizeCount = 0;
window.addEventListener("resize", function(){
  console.log('resize', resizeCount++);
});

// 以下註解後，就等於不會一開始就 trigger resize event !
// 幾乎等於 $(document).ready(function() { }
document.addEventListener("DOMContentLoaded", function(event) { 
    window.dispatchEvent(new Event('resize'));
    window.dispatchEvent(new Event('resize'));
    window.dispatchEvent(new Event('resize'));
    window.dispatchEvent(new Event('resize'));
});
```