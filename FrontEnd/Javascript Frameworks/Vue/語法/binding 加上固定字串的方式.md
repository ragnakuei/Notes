# binding 加上固定字串的方式

用 [ ] 把變數包起來

```html
<div v-for="(file,file_index) in vue_model.Files"
        v-bind:key="file_index"
        class="custom-file m-2">
    <upload-file v-bind:id="'file_index' + [file_index].toString()"
                    ></upload-file>
</div>
```