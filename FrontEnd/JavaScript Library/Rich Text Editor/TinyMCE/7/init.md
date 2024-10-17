# init

## 可同時初始化多個編輯器

```js
tinymce.init({
    license_key: 'gpl', // 免費授權
    selector: `#id1, #id2, .class1`,
});
```

取出指定的 tinyMCE 編輯器

```js
const id1Dom = tinymce.get('id1');
const id2Dom = tinymce.get('id2');

// ↓ 這個方式不支援
// 可透過 tinyMCE.get() 取出所有的 instance 來觀察 .class 的 instance 會被自動加上指定的 id
// const class1Dom = tinymce.get('.class1');
```



### [init_instance_callback](https://www.tiny.cloud/docs/tinymce/latest/editor-important-options/#init_instance_callback)

```js
init_instance_callback: (editor) => {
    console.log(`Editor: ${editor.id} is now initialized.`, editor);

    //   editor.content = "<div>初始化文字</div>";
    tinymce.activeEditor.setContent("<div>初始化文字</div>");
},
```