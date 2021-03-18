# 共用 ts - class type - 狀態保留

## 範例一

Home.vue
 - 顯示 counter
 - 按鈕按下去，counter + 1

About.vue
 - 顯示 counter

預期結果
1. Home.vue 按下多次按鈕，會立即同步 counter 的值
2. 切換至 About.vue 仍然看得到 counter 的值
3. 切換至 Home.vue 仍然看得到 counter 的值

CounterService.ts

- 直接以 instance 來 export，來達成狀態保留的目的 !

```ts
class CounterService {
    public counter: number;

    constructor() {
        this.counter = 0;
    }
}

export default new CounterService();
```

Home.vue

```html
<template>
  <div class="home">
    <img alt="Vue logo"
         src="../assets/logo.png">
    <label>{{ counterReactive.counter }}</label><br>
    <button @click="counterPlus">Plus Counter</button>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive } from 'vue';
import counterService from '@/services/CounterService';

export default defineComponent({
  name: 'Home',
  components: {},
  setup() {

    const counterReactive = reactive(counterService)

    function counterPlus() {

      // 未經過 reactive，所以不會同步更新
      // counterService.counter++;

      // 經過 reactive，所以會同步更新
      counterReactive.counter++;

      console.log(counterService.counter);
    }

    return {
      counterReactive,
      counterPlus
    };
  }
});
</script>
```

About.vue

```html
<template>
  <div class="about">
    <h1>This is an about page</h1>
    <p>{{ counter }}</p>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import counterService from '@/services/CounterService';

export default defineComponent({
  setup() {

    return {
      counter : counterService.counter
    }
  }
});
</script>
```