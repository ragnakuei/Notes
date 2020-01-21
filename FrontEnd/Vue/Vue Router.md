# [Vue Router](https://router.vuejs.org/)

- [Vue Router](#vue-router)
  - [手動安裝](#%e6%89%8b%e5%8b%95%e5%ae%89%e8%a3%9d)
  - [JS 版 語法套用](#js-%e7%89%88-%e8%aa%9e%e6%b3%95%e5%a5%97%e7%94%a8)

---

## 手動安裝

> npm install vue-router

---

## JS 版 語法套用

- 建立 /src/router.js
- 新增 route

  二種語法

  - import component 後，再指定該 Component
  - 直接以 lambda 的方式指定 import component

  ```js
  import Vue from "vue";
  import Router from "vue-router";
  import Home from "./views/Home.vue";

  Vue.use(Router);

  export default new Router({
    mode: "history",
    base: process.env.BASE_URL,
    routes: [
      {
        path: "/",
        name: "home",
        component: Home
      },
      {
        path: "/about",
        name: "about",
        component: () => import("./views/About.vue")
      }
    ]
  });
  ```

- 在 main.ts 中，加上 route 語法

  ```js
  import Vue from "vue";
  import App from "./App.vue";
  import router from "./router"; // 2

  Vue.config.productionTip = false;

  new Vue({
    router, // 1
    render: h => h(App)
  }).$mount("#app");
  ```
