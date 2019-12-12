# Javascript

[無瑕的程式碼 JavaScript](https://hackmd.io/@trylovetom/SJnKIrajH)

---

## 頁面讀取完畢後執行

```javascript
document.addEventListener("DOMContentLoaded", function() {
  // DOM Ready!
});

window.addEventListener("load", function(event) {
  // All resources finished loading!
});
```

- DOMContentLoaded

  DOMContentLoaded 事件是在 DOM 結構被完整的讀取跟解析後被觸發

- load

  load 事件是在網頁「所有」資源都已經載入完成後被觸發

[參考資料](https://ithelp.ithome.com.tw/articles/10197335)
