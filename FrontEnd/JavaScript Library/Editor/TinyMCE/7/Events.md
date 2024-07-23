# [Events](https://www.tiny.cloud/docs/tinymce/latest/events/)

### PastePreProcess

功能：在貼上前處理內容

```js
tinymce.init({
    license_key: 'gpl',
    selector: `#${this.id} #content`,
    setup: function (editor) {
        editor.on('PastePreProcess', (eventObj) => {
            // 只需要改 content 就可以調整 paste 的內容
            eventObj.content = eventObj.content + '<div>這是我加的</div>';
        });
    },
});
```
