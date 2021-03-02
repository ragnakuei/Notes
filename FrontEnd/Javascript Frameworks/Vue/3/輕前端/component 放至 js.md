# component 放至 js

- [範例](https://github.com/ragnakuei/HttpVueLoader/blob/master/HttpVueLoader/Views/Home/vue3style2.cshtml))
- 似乎只有 Rider 支援 intellisense

```html
<div id="my-app" style="display: none">
    <my-component></my-component>
</div>

<script src="https://unpkg.com/vue@3.0.5"></script>
<script src="/vue/3/my-component.js"></script>
<script>
    const { createApp, reactive } = Vue;
    const app = createApp({
    });
    app.component('my-component', my_component);
    const vm = app.mount("#my-app");
    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("my-app").style.display = "block";
    });
</script>
```

my-component.js

```js
const my_component = {
    setup() {
        const who = 'World!';

        return {
            who
        };
    },
    template: `
<h1>Hello, {{who}}</h1>
`,
};
```