# 巢狀 route 語法

- children 內的 path 也要一併帶上絕對路徑

```ts
import { createRouter, createWebHistory, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import ReservableIndex from '../views/Reservable/Index.vue'
import Account from '../views/Account/Account.vue'
import AccountLogin from '../views/Account/Login.vue'

const routes: Array<RouteRecordRaw> = [
    { path: '/', name: 'Home', component: ReservableIndex },
    {
        path: '/account',
        component: Account,
        children: [
            {
                path: '/account/login',
                component: AccountLogin
            },
        ]
    },
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})

export default router
```