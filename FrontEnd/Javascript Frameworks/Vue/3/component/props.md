# props

- [名稱大小寫要注意](https://v3.vuejs.org/guide/component-props.html#prop-casing-camelcase-vs-kebab-case)
  - 可直接改用 _ 會比較一致


## static

直接傳入純值至 prop

```
<blog-post title="My journey with Vue"></blog-post>
```

blog-post component 的 props title 拿到的是字串 `My journey with Vue` 

## dynamic

直接傳入該變數的值至 prop

```
<blog-post v-bind:title="model_title"></blog-post>
```

blog-post component 的 props title 拿到的是 binding model_title !
