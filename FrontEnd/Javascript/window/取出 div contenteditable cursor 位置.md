# 取出 div contenteditable cursor 位置

注意事項

-   不可以在 label / span / a 的 onclick 事件中使用 window.getSelection()，因為會取不到 selection

```js
function getCursorPos() {
    const selection = window.getSelection();
    // console.log('selection', selection);
    const range = selection.getRangeAt(0);
    // console.log('range', range);

    // clear selection
    // selection.removeAllRanges();
}
```

```js
function insertImageUrlToCursor(imageUrl) {
    if (!url) {
        return;
    }

    // create img tag
    const img = document.createElement('img');
    img.src = url;

    // insert img tag to selection
    const selection = window.getSelection();
    // console.log('selection', selection);
    const range = selection.getRangeAt(0);
    // console.log('range', range);
    range.insertNode(img);

    // clear selection
    selection.removeAllRanges();
}
```
