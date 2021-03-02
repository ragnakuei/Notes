# 可讀取 vue 檔

- 要讀取 Single File Components
- 套件：[http-vue-loader](https://github.com/FranckFreiburger/http-vue-loader)
- [範例](https://github.com/ragnakuei/HttpVueLoader/blob/master/HttpVueLoader/Views/Home/vue2.cshtml)
- 較多 IDE 支援 intellisense

```html
<div id="my-app">
    <h1>Hello, Vue</h1>
    <my-component></my-component>
</div>

<script src="https://cdn.jsdelivr.net/npm/vue@2.6.12"></script>
<script src="https://unpkg.com/http-vue-loader"></script>
<script>
    new Vue({
      el: '#my-app',
      components: {
        'my-component': httpVueLoader('/vue/2/my-component.vue')
      }
    });
</script>
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