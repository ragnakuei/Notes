# 每次進入都重新載入 template (1)

注意：無法套用至 binding 的屬性上，例如：`v-model`、`v-on`、`v-bind`、`v-text`、`v-html`、`v-show`、`v-if`、`v-else`、`v-else-if`、`v-for`、`v-slot`、`v-pre`、`v-cloak`、`v-once`。

只是單純運用 onMounted 會在每次進入時，被呼叫

app.js

```js
const { createApp, ref, reactive, onMounted, computed, inject } = Vue;

const [
    { router: router },
] = await Promise.all( [
    import('/js/vue/router.js'.appendVer()),
] );

window.pubSubService = publishSubscribeService; // 为了给 jsCssVerService.js 用的

const app = createApp({
    components: {
    },
    template: `
        <div class="container">
            <h3>Vue 3 Project</h3>
            <router-view></router-view>
        </div>
    `,
    setup() {
        const reload = ref(false);

        // 在路由切换时设置 reload 为 true
        router.beforeEach((to, from, next) => {
            reload.value = true;
            next();
        });

        return {
            reload
        };
    }
});

app.component('DynamicComponent', {
    props: ['component'],
    template: `
        <component :is="component"></component>
    `
});

app.directive('dynamic', {
    mounted(el, binding) {
        el.innerHTML = binding.value;
    },
    updated(el, binding) {
        el.innerHTML = binding.value;
    }
});

app.use(router).mount('#app');
```
router.js

```js
const { createRouter, createWebHistory } = VueRouter;

const router = createRouter( {
    history: createWebHistory(),
    routes: [
        { path: '', component: () => import('/js/vue/components/home.js'), },
        { path: '/privacy', component: () => import('/js/vue/components/privacy.js'), },
    ]
} )

export { router };

```


about.js

```js
const { defineComponent, onMounted, ref, inject } = Vue;
const ajaxService = await import('/js/vue/services/ajaxService.js'.appendVer());
export default defineComponent({
    template: `
        <div v-dynamic="template"></div>
    `,
    setup() {
        const template = ref(html);

        onMounted(async () => {
            template.value = await ajaxService.html('post', '/html/about');
        });

        return {
            template
        };
    }
});
```
