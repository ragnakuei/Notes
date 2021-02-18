# 共用 ts - primitive type

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

counter.ts

- 因為要讓 counter 如實反映至需要的地方，所以必須將 counter 以 ref 包裝

```ts
import { ref } from 'vue';

const counter = ref(0);

export default counter;
```

Home.vue

```vue
<template>
    <div class="home">
        <img alt="Vue logo"
             src="../assets/logo.png">
        <label>{{ counter }}</label><br>
        <button @click="counterPlus">Plus Counter</button>
    </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue';
import c from '@/services/counter';

export default defineComponent({
    name: 'Home',
    components: {
    },
    setup() {

        function counterPlus() {
            c.value ++ ;
        }

        return {
            counter,
            counterPlus
        };
    }
});
</script>
```

About.vue

```vue
<template>
    <div class="about">
        <h1>This is an about page</h1>
        <p>{{ counter }}</p>
    </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue';
import counter from '@/services/counter';

export default defineComponent({
    setup() {

        return {
            counter
        }
    }
});
</script>
```