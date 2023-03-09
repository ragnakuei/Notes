# IntersectionObserver


### 範例

#### 看到某個 dom 顯示，觸發指定的事件


```js
const observer = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      // 觸發事件 here
    }
  });
});

const targetElement = document.querySelector("#target");

observer.observe(targetElement);
```

