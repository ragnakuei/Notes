# [TinyMCE v3](https://www.tiny.cloud/docs-3x/)

## [editor instance](https://www.tiny.cloud/docs-3x/api/html/class_tinymce.html/)

- 變數名：：tinyMCE
- singleton pattern
- TinyMCE 的基本 class

## [Editor](https://www.tiny.cloud/docs-3x/api/class_tinymce.Editor.html/)

- 可以透過 tinyMCE.get('dom_id') 取得

### getContent()

取出該 Editor 內的值

### [remove()](https://www.tiny.cloud/docs-3x/api/html/class_tinymce.html/#remove)

把 instance 移除 tinymce 的套用，指定的 textare 就會被還原，可重新透過 `tinyMCE.init({})` 建立


## init

### [mode](https://www.tiny.cloud/docs-3x/reference/Configuration3x/Configuration3x@mode/)

```js
tinyMCE.init({
    mode : "exact",     // exact / textareas
    elements : "elm2",  // 指定要使用的textarea的id，多个用逗号隔开
    theme : "simple"
});
```

### [elements](https://www.tiny.cloud/docs-3x/reference/Configuration3x/Configuration3x@elements/)

## callback

### [init_instance_callback](https://www.tiny.cloud/docs-3x/reference/Configuration3x/Configuration3x@init_instance_callback/)

回傳的資料型態與 `tinyMCE.get('dom_id')` 一致