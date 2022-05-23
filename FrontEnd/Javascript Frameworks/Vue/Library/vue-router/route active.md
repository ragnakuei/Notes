# route active

## 全域給定

```js
import { createRouter, createWebHashHistory } from "vue-router";
const routes = [
    {  path: "/", component: () => import("../components/Home.vue"), },
    {  path: "/users", component: () => import("../components/Users.vue"), },
]
export default createRouter({
    history: createWebHashHistory(),
    linkActiveClass: "active",
    routes
});
```

## 區域給定

- 在 router link 加上 active-class 給定其 active 的 class

```html
<li class="nav-item">
    <router-link active-class="active1" to="/" class="nav-link">Home</router-link>
</li>
<li class="nav-item">
    <router-link active-class="active2" to="/users" class="nav-link">Users</router-link>
</li>
```