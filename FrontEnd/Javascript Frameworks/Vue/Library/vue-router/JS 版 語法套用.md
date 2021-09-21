# JS 版 語法套用

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