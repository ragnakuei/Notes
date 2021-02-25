# 共用 ts - class type - 狀態不保留

- 直接以 reactive() 包裝整個 ts service，就可以達成狀態的同步 !

## 範例一

Home.vue
 - 顯示 counter
 - 按鈕按下去，counter + 1

預期結果
1. Home.vue 按下多次按鈕，會立即同步 counter 的值
2. 切換至別的頁面後，再切換至 Home.vue，counter 的值歸 0

---

CounterService.ts

```ts
export default class CounterService {
    public counter: number;

    constructor() {
        this.counter = 0;
    }
}
```

Home.vue

```html
<template>
  <div class="home">
    <img alt="Vue logo"
         src="../assets/logo.png">
    <label>{{ counterService.counter }}</label>
    <button @click="plusCounter">Plus Counter</button>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive } from 'vue';
import CounterService from "@/services/CounterService";

export default defineComponent({
  name: 'Home',
  components: {},
  setup() {

    const counterService = reactive(new CounterService());

    function plusCounter() {
      counterService.counter++;

      console.log(counterService.counter);
    }

    return {
      counterService,
      plusCounter,
    }
  }
});
</script>
```
