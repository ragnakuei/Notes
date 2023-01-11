# Selection

## 取得 Selection

```js
const selection = window.getSelection();

// 取得選取範圍
if (selection.rangeCount > 0) {
    // 取得第一個選取範圍
    const range = selection.getRangeAt(0);

    // 插入圖片
    const img = document.createElement("img");
    img.src = "http://placekitten.com/200/300";
    range.insertNode(img);
}
```

