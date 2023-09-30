# props

- [名稱大小寫要注意](https://v3.vuejs.org/guide/component-props.html#prop-casing-camelcase-vs-kebab-case)
  - 可直接改用 _ 會比較一致


#### static

直接傳入純值至 prop

```
<blog-post title="My journey with Vue"></blog-post>
```

blog-post component 的 props title 拿到的是字串 `My journey with Vue` 

#### dynamic

直接傳入該變數的值至 prop

```html
<blog-post v-bind:title="model_title"></blog-post>
```

blog-post component 的 props title 拿到的是 binding model_title !


支援 destructuring

假設 obj 為

```js
{
  a : 1,
  b : 2,
  c : 3,
}
```

那麼可以直接以 v-bind="obj" 的方式傳入 vue component 中，會直接 destructuring 為  props 所需要的 properties

```html
<my-component v-bind="obj"></my-component>

<script>
app.component('my-component', {
  props: ['a', 'b'],
  template: `
    <div>
      <p>{{ a }}</p>
      <p>{{ b }}</p>
    </div>
  `
})
```

#### 預設值給定方式

```js
  app.component("component-a", {
      props: {
          // 宣告型別 且 給定預設值
          message: {
              type: String,
              default: "Hello World2",
          },
      },
      template: `
      <div>
          <h3>Component A</h3>
          <p>{{ message }}</p>
      </div>
      `,
  });
```