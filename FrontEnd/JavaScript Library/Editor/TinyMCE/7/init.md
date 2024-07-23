# init

## [init_instance_callback](https://www.tiny.cloud/docs/tinymce/latest/editor-important-options/#init_instance_callback)

```js
init_instance_callback: (editor) => {
    console.log(`Editor: ${editor.id} is now initialized.`, editor);

    //   editor.content = "<div>初始化文字</div>";
    tinymce.activeEditor.setContent("<div>初始化文字</div>");
},
```