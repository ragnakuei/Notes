# EventBus

## 範例

### 建立 evenBus const

main.ts

```ts
import Vue from 'vue'
import App from './App.vue'
import router from './router'

Vue.config.productionTip = false

// 加上這一行
export const eventBus = new Vue()

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')

```

### 註冊事件

注意 `eventBus` 的使用

```html
<template>
    <div>
        <p>
            <label>First Name:</label>
            <input :value="firstName" @change="onChangeFirstName">
        </p>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from "vue-property-decorator";
    import { eventBus } from "@/main"

    @Component
    export default class TestChild4 extends Vue {
        constructor() {
            super();

            this.firstName = 'firstName';
        }

        private onChangeFirstName(target: MouseEvent) {
            const input = target?.target as HTMLInputElement;
            eventBus.$emit("onChangeFirstName", input?.value);
            console.log(`TestChild4.FirstName:${ input?.value }`);
        }

        private firstName: string;
    }
</script>
```


### 事件 callback

```html
<template>
    <div>
        <p>TestChild4</p>
        <TestChild4/>

    </div>
</template>
<script lang="ts">
    import { Component, Vue } from "vue-property-decorator";
    import TestChild4 from "@/views/TestChild4.vue";
    import { eventBus } from "@/main"

    @Component({
        components: { TestChild4 }
    })
    export default class Test extends Vue {

        constructor() {
            super();
        }

        mounted() {

            // 以下二種語法都可以
            // eventBus.$on("onChangeFirstName", this.onChangeFirstName );
            // eventBus.$on("onChangeFirstName", (value: string) => this.onChangeFirstName(value) );

            eventBus.$on("onChangeFirstName", (value: string) => {
                this.onChangeFirstName(value);
            });
        }

        private onChangeFirstName(value: string): void {
            console.log(`FirstName:${ value }`);
        }
    }
</script>
```
