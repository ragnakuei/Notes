# Spinner

## 範例 01

Spinner.vue

- 記得要放在最外層的 component template 內

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
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(0, 0, 0, 0.2);
    z-index: 999;
}
</style>
```

store/spinner.js

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

[呼叫端語法](../AxiosService%20範例%2001.md)


