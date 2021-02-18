# [vue-router](https://router.vuejs.org/)

- [Vue Router](#vue-router)
  - [手動安裝](#%e6%89%8b%e5%8b%95%e5%ae%89%e8%a3%9d)
  - [JS 版 語法套用](#js-%e7%89%88-%e8%aa%9e%e6%b3%95%e5%a5%97%e7%94%a8)
  - [不要使用 router 的 hash tag 符號](#%e4%b8%8d%e8%a6%81%e4%bd%bf%e7%94%a8-router-%e7%9a%84-hash-tag-%e7%ac%a6%e8%99%9f)
    - [做法](#%e5%81%9a%e6%b3%95)

---

## 透過 vue cli 自動安裝

> vue add router

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

---

## 不要使用 router 的 hash tag 符號

預設的 router url 會長這樣

> http://192.168.8.102:8080/#/helloWorld

可以讓 router url 長成這樣

> http://192.168.8.102:8080/helloWorld

### 做法

在 new Router() 時，加上 `mode: 'history'` 就可以了

```js
export default new Router({
    mode: 'history',       // add here
    routes: [
        {
            path: '/',
            name: 'home',
            component: Home
        },
        {
            path: '/helloWorld',
            name: 'helloWorld',
            component: HelloWorld
        }
    ]
})
```