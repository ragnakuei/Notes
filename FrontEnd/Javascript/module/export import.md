# export import

當 export default 時，就可以用下面的方式 import

```js
import Vue from 'vue';
```

當 export 明確明稱，而不是 default 時，就要用下面的方式 import

-   必預要用 { } 包起來

```js
import { createApp } from 'vue';
```

## await export

- js 檔案可以用 await 語法
- 就算 await 語法在 export 之後，也會執行，並且會執行該檔案所有程式


```js
// 單一 動態 import
export default await import(
    'https://unpkg.com/vue@3/dist/vue.esm-browser.js'
).then((module) => {
    const { defineComponent } = module;

    return defineComponent({
        template: `<h3>Home</h3>`,
    });
});
```

```js
// 多個 動態 import
export default await Promise.all([
    import('https://unpkg.com/vue@3/dist/vue.esm-browser.js'),  // vue1
    import('https://unpkg.com/vue@3/dist/vue.esm-browser.js'),  // vue2
]).then(([vue1, vue2]) => {
    console.log('vue1', vue1);
    console.log('vue2', vue2);

    const { defineComponent } = vue;

    return defineComponent({
        template: `<h3>Home</h3>`,
    });
});
```
