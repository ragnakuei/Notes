# 不要使用 router 的 hash tag 符號

預設的 router url 會長這樣

> http://192.168.8.102:8080/#/helloWorld

可以讓 router url 長成這樣

> http://192.168.8.102:8080/helloWorld

### 做法一

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

### 做法二

新版做法

```ts
import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import ReservableIndex from '../views/Reservable/Index.vue'

const routes: Array<RouteRecordRaw> = [
    { path: '/', name: 'Home', component: ReservableIndex },
]

const router = createRouter({
    history: createWebHistory(),    // 這裡從 createWebHashHistory 改成 createWebHistory
    routes,
})

export default router
```