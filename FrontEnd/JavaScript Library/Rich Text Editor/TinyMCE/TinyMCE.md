# [TinyMCE](https://www.tiny.cloud)

-   [Document](https://www.tiny.cloud/docs/)

-   [Full Featured: Non-Premium Plugins](https://www.tiny.cloud/docs/demo/full-featured/#fullfeaturednon-premiumplugins)

-   [How to get content and set content in TinyMCE](https://www.tiny.cloud/blog/how-to-get-content-and-set-content-in-tinymce/)

## APIs

-   setContent()
-   getContent()

### 加入事件的方式

-   `editor` 等於 `tinyMCE.getInstanceById(selector)`

```js
tinymce.init({
    selector: 'textarea#' + props.id,
    language: 'zh_TW',

    setup: function (editor) {
        // 初始化時，將 vue 內容寫至 tinymce 中
        editor.on('init', function (e) {
            editor.setContent(dom_value.value);
        });

        // 內容回寫至 vue 中
        editor.on('Change KeyUp Undo Redo', function (e) {
            console.log('change');

            dom_value.value = editor.getContent();
        });
    },
});
```

### 圖片上傳

#### [images_upload_url](https://www.tiny.cloud/docs/tinymce/latest/upload-images/#images_upload_url)

#### [images_upload_handler](https://www.tiny.cloud/docs/tinymce/latest/upload-images/#images_upload_handler)

```js
tinymce.init({
    license_key: 'gpl', // 免費授權
    selector: `#${this.id} #content`,
    language: 'zh_TW',

    resize: false,
    menubar: false,
    plugins: [],
    toolbar: '',
    toolbar_items_size: '', //大小
    font_formats: '',
    contextmenu: '',
    image_description: false,
    content_style: 'img { width: 20%;height: 20%; }',

    // statusbar:             false, // 隱藏下方狀態列
    // paste_data_images:     true,

    // 自訂圖片上傳邏輯
    images_upload_handler: (blobInfo, success, failure, progress) =>
        new Promise((resolve, reject) => {
            const blobInfoResult = {
                base64: blobInfo.base64(),
                blob: blobInfo.blob(),
                blobUri: blobInfo.blobUri(),
                filename: blobInfo.filename(),
                id: blobInfo.id(),
                name: blobInfo.name(),
                uri: blobInfo.uri(),
            };
            console.log('images_upload_handler > blobInfo', blobInfoResult);

            const uploadUrl = '/TinyMCE/UploadImage';
            const formData = new FormData();
            formData.append('id', this.querySelector('#id').value);
            formData.append('file', blobInfo.blob(), blobInfo.filename());

            fetch(uploadUrl, {
                method: 'POST',
                body: formData,
            })
                .then((response) => response.json())
                .then((imageUrl) => {
                    console.log('images_upload_handler > imageUrl', imageUrl);
                    // success( imageUrl );
                    // imageUrl 會被放在 img src 中
                    resolve(imageUrl);
                })
                .catch((error) => {
                    console.error('images_upload_handler > error', error);
                    // failure( 'error' );
                    reject(error);
                });
        }),

    // 讓 img src 可以以 / 開頭
    relative_urls: false,
    // setup:           function ( editor ) {
    // },
});
```
