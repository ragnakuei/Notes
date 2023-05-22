# cdn 版範例

此為[官網範例](https://router.vuejs.org/guide/)

- vue 只能使用 js 版本，不能使用 esm 版本
- 只要套件內的 vue 使用來源是 import xxx from 'vue' 的方式，就是還要 importmap !!

```html
<html lang="en">

<head>
    <meta charset="utf-8">
</head>

<body>

    <p>目的：</p>
    <pre>
        router 的使用方式
        要套用 vue-router 就必須要使用 js 版的 vue，不能使用 esm 版的 vue
    </pre>

    <div id="app">
        <h1>Router</h1>
        <div>
            <p>nav</p>
            <router-link to="/">Home</router-link>
            <router-link to="/about">About</router-link>
            <router-link to="/privacy">Pricy</router-link>
        </div>
        <div>
            <p>以下是 router-view</p>
            <router-view></router-view>
        </div>
    </div>

    <script src="https://unpkg.com/vue@3"></script>
    <script src="https://unpkg.com/vue-router@4"></script>

    <script>
        const { ref, onMounted, computed } = Vue;
        const { createRouter, createWebHashHistory } = VueRouter;

        const router = createRouter({
            history: createWebHashHistory(),
            routes: [
                { path: '/', component: () => import('/vue/module/home.js') },
                { path: '/about', component: () => import('/vue/module/about.js') },
                { path: '/privacy', component: () => import('/vue/module/privacy.js') },
            ]
        })

        const app = Vue.createApp({
            components: {
                // 這邊用來定義直接使用的 components
            },
            setup() {
                const show = ref(false);

                return {
                    show,
                }
            }
        }).use(router)
          .mount('#app');
    </script>



</body>

</html>
```





esm 版範例

- 只要套件內的 vue 使用來源是 import xxx from 'vue' 的方式，就是還要 importmap !!

```html
<html lang="en">

<head>
    <meta charset="utf-8">
</head>

<body>

    <p>目的：</p>
    <pre>
        router 的使用方式
    </pre>

    <div id="app">
        <h1>03</h1>
        <div>
            <p>nav</p>
            <router-link to="/">Home</router-link>
            <router-link to="/about">About</router-link>
            <router-link to="/privacy">Pricy</router-link>
        </div>
        <div>
            <p>以下是 router-view</p>
            <router-view></router-view>
        </div>
    </div>

    <script type="importmap">
        {
            "imports": {
                "vue": "https://unpkg.com/vue@3/dist/vue.esm-browser.js",
                "@vue/devtools-api": "https://unpkg.com/@vue/devtools-api@6/lib/esm/index.js"
            }
        }
    </script>
    <script type="module">
        import { createApp, defineAsyncComponent, ref, reactive, watch, computed } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js';
        import { createRouter, createWebHashHistory } from 'https://unpkg.com/vue-router@4/dist/vue-router.esm-browser.js';

        const router = createRouter({
            history: createWebHashHistory(),
            routes: [
                { path: '/', component: () => import('/vue/module/home.js') },
                { path: '/about', component: () => import('/vue/module/about.js') },
                { path: '/privacy', component: () => import('/vue/module/privacy.js') },
            ]
        })

        const app = createApp({
            components: {
                // 這邊用來定義直接使用的 components
            },
            setup() {
                const show = ref(false);

                return {
                    show,
                }
            }
        }).use(router)
            .mount('#app');
    </script>



</body>

</html>
```