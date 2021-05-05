# [TinyMCE](https://www.tiny.cloud)

-   [Document](https://www.tiny.cloud/docs/)

- [Full Featured: Non-Premium Plugins](https://www.tiny.cloud/docs/demo/full-featured/#fullfeaturednon-premiumplugins)

- [How to get content and set content in TinyMCE](https://www.tiny.cloud/blog/how-to-get-content-and-set-content-in-tinymce/)

## APIs

- setContent()
- getContent()

### 加入事件的方式

- `editor` 等於 `tinyMCE.getInstanceById(selector)`

```js
            tinymce.init({
                selector: 'textarea#' + props.id,
                language: "zh_TW",

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
                }
            });

```