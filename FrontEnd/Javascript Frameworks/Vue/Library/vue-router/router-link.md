# router-link


##### src 綁定 route name

```ts
import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import Home from "../views/home.vue";

const routes: Array<RouteRecordRaw> = [
    {
        path: "/",
        name: "Home",
        component: Home,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
```

```html
<router-link v-bind:to="{ name: 'Home' }" class="nav-link">Home</router-link>
```
