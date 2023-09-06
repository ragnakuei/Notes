# 每次進入都重新載入 template (2)

## 範例

注意：可以套用至 binding 的屬性上，例如：`v-model`、`v-on`、`v-bind`、`v-text`、`v-html`、`v-show`、`v-if`、`v-else`、`v-else-if`、`v-for`、`v-slot`、`v-pre`、`v-cloak`、`v-once`。

運用以下二個技巧：

1. onMounted 會在每次進入時被呼叫
1. dynamic component
    - 原本 component is 綁定至已經存在的 component
    - 也可以綁定至動態產生的 component (defineComponent)

簡單說就是把既有的 definedComponent，改成動態產生的 component

app.js

```js
const { createApp, ref, reactive, onMounted, computed, inject } = Vue;

const [{ router: router }] = await Promise.all([
    import('/js/vue/router.js'.appendVer()),
]);

window.pubSubService = publishSubscribeService; // 为了给 jsCssVerService.js 用的

const app = createApp({
    components: {},
    template: `
        <div class="container">
            <h3>Vue 3 Project</h3>
            <router-view></router-view>
        </div>
    `,
    setup() {
        return {};
    },
});

app.use(router).mount('#app');
```

router.js

```js
const { createRouter, createWebHistory } = VueRouter;

const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '', component: () => import('/js/vue/components/home.js') },
        {
            path: '/privacy',
            component: () => import('/js/vue/components/privacy.js'),
        },
    ],
});

export { router };
```

about.js

```js
const { defineComponent, onMounted, onUnmounted, ref, shallowRef, nextTick, defineAsyncComponent, } = Vue;
const { useRouter } = VueRouter;
const [
    { default: icon },
    ajaxService,
] = await Promise.all([
    import('/js/vue/components/shared/icon.js'.appendVer()),
    import('/js/vue/services/ajaxService.js'.appendVer()),
]);

export default defineComponent({
    template: `
    <div>
      <!-- 動態產生的 component -->
      <component :is="currentComponent"></component>
    </div>    `,
    setup() {
        // 這邊一定要用 shallowRef，不然會有警告訊息
        const currentComponent = shallowRef(null);

        onMounted(async () => {
            // 從後端取得 html
            const html = await ajaxService.html('post', '/html/about');

            // 定義 component，內容就跟原本的一樣
            currentComponent.value = defineComponent({
                components: {
                    pagination,
                    icon,
                },

                template: html,
                setup() {
                    // 把原本 defineComponent 的 setup 搬到這裡

                    return {};
                },
            });
        });

        return {
            currentComponent,
        };
    },
});
```

## 樣板

```js
const { defineComponent, onMounted, onUnmounted, ref, shallowRef, nextTick, defineAsyncComponent, } = Vue;
const { useRouter } = VueRouter;
const [
    { default: icon },
    ajaxService,
] = await Promise.all([
    import('/js/vue/components/shared/icon.js'.appendVer()),
    import('/js/vue/services/ajaxService.js'.appendVer()),
]);

export default defineComponent({
    template: `
    <div>
      <!-- 動態產生的 component -->
      <component :is="currentComponent"></component>
    </div>    `,
    setup() {
        // 這邊一定要用 shallowRef，不然會有警告訊息
        const currentComponent = shallowRef(null);

        onMounted(async () => {
            // 從後端取得 html
            const html = await ajaxService.html('http method', 'template url');

            // 定義 component，內容就跟原本的一樣
            currentComponent.value = defineComponent({
                components: {
                    pagination,
                    icon,
                },

                template: html,
                setup() {
                    // 把原本 defineComponent 的 setup 搬到這裡

                    return {};
                },
            });
        });

        return {
            currentComponent,
        };
    },
});
```
