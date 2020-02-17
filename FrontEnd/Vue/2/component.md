# [Component](https://vuejs.org/v2/guide/components.html)

- [Component](#component)
  - [Module System](#module-system)
    - [import](#import)
  - [外部給定 Property 值](#%e5%a4%96%e9%83%a8%e7%b5%a6%e5%ae%9a-property-%e5%80%bc)

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
---

## 外部給定 Property 值

- 要接外部 Property 的 Component

    ```html
    <template>
        <button @click="count++">You clicked me {{ count }} times.</button>
    </template>

    <script>
        export default {
            name: "clickCountButton",
            props: ['initialCounter'],
            data() {
                return {
                    count : this.initialCounter
                }
            }
        }
    </script>
    ```

- 給定 Component Property 的方式

    > :Property="值"

    > v-bind:Property="值"

    ```html
    <template>
        <div>
            <clickCountButton :initialCounter="10" />
            <clickCountButton :initialCounter="20" />
            <!-- 這樣也可以 -->
            <!-- <clickCountButton v-bind:initialCounter="20" /> -->
        </div>
    </template>

    <script>
        import clickCountButton from "@/views/ClickCountButton.vue"
        
        export default {
            components : {
                clickCountButton
            },
            data() {
                return {
                }
            }
        } 
    </script>
    ```

