# 加入 router

安裝 [vue-router](https://next.router.vuejs.org/installation.html)

> npm install vue-router@next

建立 /router/index.ts 檔案

```ts
import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import Home from "../views/Home.vue";
import Calendar from "../views/Calendar.vue";

const routes : Array<RouteRecordRaw> = [
    { path: "/", name: "Home", component: Home, },
    { path: "/Calendar", name: "Calendar", component: Calendar, },
    // {
    //   path: "/about",
    //   name: "About",
    //   // route level code-splitting
    //   // this generates a separate chunk (about.[hash].js) for this route
    //   // which is lazy-loaded when the route is visited.
    //   component: () =>
    //     import(/* webpackChunkName: "about" */ "../views/About.vue"),
    // },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
```


main.js

- 加入 router 引用

```js
import { createApp } from 'vue'
import App from './App.vue'
import router from "./router/index";
import './main.css'

createApp(App)
    .use(router)
    .mount('#app')
```