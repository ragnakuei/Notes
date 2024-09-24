# source code 無法在 bootstrap modal 內編輯

這邊說的 source code 是指 TinyMCE 的 source code plugin，不是指網頁原始碼。


在 boostrap 5 modal ，必須加上以下的事件，才能讓 TinyMCE 在 modal 內正常運作：

```js
document.addEventListener("focusin", (e) => {
    if (e.target.closest(".tox-tinymce-aux, .moxman-window, .tam-assetmanager-root") !== null) {
        e.stopImmediatePropagation();
    }
});
```

在 boostrap 4 modal ，必須加上以下的事件，才能讓 TinyMCE 在 modal 內正常運作：

```js
$(".modal").on('shown.bs.modal', () => {
    $(document).off('focusin.modal');
});
```

