# Suspense

[Vue3 的新功能 — Suspense](https://medium.com/i-am-mike/vue-3-vue3-%E7%9A%84%E6%96%B0%E5%8A%9F%E8%83%BD-suspense-428e02254030)

[Lazy loading components in Vue 3](https://dev.to/jsbroks/lazy-loading-components-in-vue-3-21o7)

[範例一](https://codesandbox.io/s/vue-3-suspense-forked-zz14n)

[範例二](https://codesandbox.io/s/using-suspense-and-async-setup-in-vue-3-f0rc1)

---

## 範例一

Loading.vue

- 顯示 Loading

    ```html
    <script>
    export default {};
    </script>

    <template>
    <div>
        Loading
    </div>
    </template>

    <style scoped>
    </style>
    ```

WithLoading.vue

- 實作 Suspense
- 用來包住要顯示的 View

    ```html
    <template>
    <Suspense>
        <template #default>
        <slot></slot>
        </template>
        <template #fallback>
        <Loading></Loading>
        </template>
    </Suspense>
    </template>

    <script lang="ts">
    import { onErrorCaptured } from "vue";
    import Loading from "@/components/Loading.vue";

    export default {
    name: "WithLoading",
    components: {
        Loading,
    },
    setup() {
        onErrorCaptured((error) => {
        console.log("error occurs：", error);
        });

        return {};
    },
    };
    </script>

    <style>
    </style>
    ```

A.vue

- 用來包住 WithLoading 的主頁

    ```html
    <template>
    <div>
        <p>A</p>
        <WithLoading>
        <AChild></AChild>
        </WithLoading>
    </div>
    </template>

    <script lang="ts">
    import { defineComponent } from 'vue';
    import WithLoading from "@/components/WithLoading.vue";
    import AChild from "@/views/A-Child.vue";

    export default defineComponent({
    name: 'A',
    components: {
        AChild,
        WithLoading,
    },
    });
    </script>
    ```

A-Child.vue

- 等 2 秒才會初始化完成的頁面

    ```html
    <template>
    <div>
        A-Child
    </div>
    </template>

    <script lang="ts">
    import { defineComponent } from 'vue';

    export default defineComponent({
    name: 'A-Child',
    components: {
    },
    async setup(){

        await new Promise((r) => setTimeout(r, 2000));

        return {};
    }
    });
    </script>
    ```
