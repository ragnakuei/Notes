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

                    // 在這裡加上 keyup 事件
                    editor.on('keyup', function (e) {
                        console.log('keyup');

                        editor.setContent('<p>Hello world!</p>');
                    });
                }
            });

```