# 可讀取 vue 檔

- 要讀取 Single File Components
- 套件：[vue3-sfc-loader](https://github.com/FranckFreiburger/vue3-sfc-loader)
- [範例](https://github.com/ragnakuei/HttpVueLoader/blob/master/HttpVueLoader/Views/Home/vue3style1.cshtml))
- 較多 IDE 支援 intellisense

```html
<div id="my-app"
     style="display: none">
    <h1>Hello, Vue</h1>
    <my-component></my-component>
</div>

<script src="https://unpkg.com/vue@3.0.5"></script>
<script src="https://cdn.jsdelivr.net/npm/vue3-sfc-loader"></script>
<script src="/vue/3/vue3-sfc-loader.js"></script>
<script>
    const { createApp, reactive } = Vue;
    const { loadModule, version } = window["vue3-sfc-loader"];

    const app = createApp({

    });
    app.component('my-component', Vue.defineAsyncComponent(() => loadModule('/vue/3/my-component.vue', options)));
    const vm = app.mount("#my-app");

    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("my-app").style.display = "block";
    });
</script>
```

vue3-sfc-loader.js

- 這個檔案提供 vue3-sfc-loader option 設定

    ```js
    const options = {

        moduleCache: {
            vue: Vue
        },

        async getFile(url) {

            const res = await fetch(url);
            if ( !res.ok )
                throw Object.assign(new Error(url+' '+res.statusText), { res });
            return await res.text();
        },

        addStyle(textContent) {

            const style = Object.assign(document.createElement('style'), { textContent });
            const ref = document.head.getElementsByTagName('style')[0] || null;
            document.head.insertBefore(style, ref);
        },
    }
    ```


my-component.vue

```vue
<template>
    <h1>Hello, {{who}}</h1>
</template>

<script>
module.exports = {
    data: function() {
        return {
            who: 'World!'
        }
    }
}
</script>

<style scoped>
h1 {
    text-align: center;
    font-family: sans-serif;
    background: red;
    padding: 1rem;
}
</style>
```