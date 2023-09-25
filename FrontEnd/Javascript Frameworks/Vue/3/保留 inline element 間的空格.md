# 保留 inline element 間的空格

```js
const app = Vue.createApp({
    setup() {
        return {

        }
    }
});
// 保留 inline element 間的空格的設定
app.config.compilerOptions.whitespace = 'preserve';
app.mount('#app');
```