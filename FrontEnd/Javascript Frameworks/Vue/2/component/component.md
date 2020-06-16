# [Component](https://vuejs.org/v2/guide/components.html)

- [Component](#component)
  - [Module System](#module-system)
    - [import](#import)

---

component 
- 只能有一個 root element

---

## [Module System](https://vuejs.org/v2/guide/components-registration.html#Module-Systems)

不同 Component 間互相引用的機制

```html
<template>
    <div>
        <p>Home</p>
        <Order/>
    </div>
</template>

<script>
    import Order from "@/views/Order";

    export default {
        name: 'home',
        components: {
            Order
        }
    }
</script>

```

### import

- 絕對路徑

    Rider 目前無法辨識

    ```ts
    import Order from "@/views/Order";
    ```

- 相對路徑

    Rider 可辨識

    ```ts
    import Order from "./Order";
    ```
