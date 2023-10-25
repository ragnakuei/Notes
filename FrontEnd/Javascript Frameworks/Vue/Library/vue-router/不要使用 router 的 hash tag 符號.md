# 不要使用 router 的 hash tag 符號

預設 mode 是 hash，雖然可以改為 history
★★★ 但在發佈後，就必須在 web server 上設定 url rewrite 才能正常運作 !

多了 # 的目的是，讓瀏覽器不會重新發送 request，而是在前端處理 !

mode 為 history，可以視為在 dev 環境下模擬了 url rewrite 的效果 !

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