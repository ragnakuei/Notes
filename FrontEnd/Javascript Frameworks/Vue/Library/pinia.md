# pinia

# [cdn 做法](https://github.com/vuejs/pinia/discussions/1051)

```html
<!-- 引用 pinia 的前置套件 -->
<script integrity="sha384-JyvwnGIUeQ9WfWGvbZTq3NK1ddtXc0JPTb5Du5qIIlJqxJAmnXzT99SxxA2EsQqk"
        src="/lib/vue-demi/0.14.4/index.iife.min.js"></script>

<script integrity="sha384-zhS6NK/liaTGMeeIj+/kM/KDZzlajlPu0zhI9r6gJ+ROi3wG5KWnJk1Qoe3V/n3Z" 
        src="/lib/pinia/2.1.1/pinia.iife.min.js"></script>

<script>
    const app = Vue.createApp({})
                   .use(Pinia.createPinia());
    app.mount('#app');
</script>
```