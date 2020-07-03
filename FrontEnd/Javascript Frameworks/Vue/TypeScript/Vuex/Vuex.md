# Vuex

## 無參數範例

註冊 Vuex 至 store 中

建立 store

```ts
import Vue from 'vue'
import Vuex from 'vuex'
import App from './App.vue'
import router from './router'

Vue.config.productionTip = false

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    count: 0
  },
  mutations: {
    increment (state) {
      state.count++
    }
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

```

透過 commit store > mutations > function name 來呼叫動作

透過 this.$store > 取得 state 中指定 property 的值

```ts
<template>
    <div>
        <p>Count</p>
        <input :value="count"/>
        <p>
            <button @click="increase">increase</button>
        </p>
    </div>
</template>
<script lang="ts">
    import { Component, Vue } from "vue-property-decorator";

    @Component({
        components: {}
    })
    export default class Test extends Vue {

        constructor() {
            super();
        }

        get count(): number {
            return this.$store.state.count;
        }

        increase(): void {
            this.$store.commit('increment')
        }
    }
</script>
```
---

## 給定 payload 範例

從上面的範例新增了 storeData 跟 increment2

```ts
import Vue from 'vue'
import Vuex from 'vuex'
import App from './App.vue'
import router from './router'

Vue.config.productionTip = false

export const eventBus = new Vue()

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    count: 0,
    storeData : '',
  },
  mutations: {
    increment (state) {
      state.count++
    },

    increment2 (state, obj) {
      state.storeData = obj;
    }
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

```

新增 get property storeData

increase() 新增了一行 `this.$store.commit('increment2', 'test')`

```ts
<template>
    <div>
        <p>
            count
            <input :value="count"/>
        </p>
        <p>
            storeDdat
            <input :value="storeData"/>
        </p>
        <p>
            <button @click="increase">increase</button>
        </p>
    </div>
</template>
<script lang="ts">
    import { Component, Vue } from "vue-property-decorator";

    @Component({
        components: {}
    })
    export default class Test extends Vue {

        constructor() {
            super();
        }

        get count(): number {
            return this.$store.state.count;
        }

        get storeData(): string {
            return this.$store.state.storeData;
        }

        increase(): void {
            this.$store.commit('increment')

            this.$store.commit('increment2', 'test')
        }
    }
</script>
```