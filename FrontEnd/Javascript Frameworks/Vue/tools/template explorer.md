# template explorer

https://vue-next-template-explorer.netlify.app/


如果有些語法不符合預期時，可以丟上去比較一下

例：

比較這個與這個

```html
<p v-for="(item, index) in vue_model.Items" :key="index">
    <input type="text" v-model="item" />
</p>

```

```html
<p v-for="(item, index) in vue_model.Items" :key="index">
    <input type="text" v-model="vue_model.Items[index]" />
</p>
```

