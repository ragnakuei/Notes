# 跨 component 存取 js 中的 ref 變數

## 範例 01

spinner.js

- 其他 vue 會直接呼叫 on() / off() 方法

```js
import { ref, computed } from "vue";

export default new class store {

    #requestCount = ref( [] );

    constructor() {
    }

    on() {
        // console.log('on');
        this.#requestCount.value.push('');
    }

    off() {
        // console.log('off');
        this.#requestCount.value.pop();
    }

    status = computed (() => {
        // console.log( 'this.#requestCount.value.length', this.#requestCount.value.length );
        return this.#requestCount.value.length > 0;
    })
}
```

Spinner.vue

- 此 component 直接 binding 至 store 的 status 變數時，要加上 value
- 此範例是 computed，但用 ref 仍然要加 .value

```js
<template>
    <div class='wrapper d-flex justify-content-center'
         v-if='spinnerStore.status.value'>
        <div class='spinner spinner-border'
             role='status'>
            <span class='visually-hidden'>Loading...</span>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import spinnerStore from "../store/spinner";
</script>

<style scoped>
.wrapper {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(0, 0, 0, 0.2);
    z-index: 100;
}
</style>

```

## 範例 02

[參考 route 來產生 breadcrumb](./Examples/參考%20route%20來產生%20breadcrumb.md)
