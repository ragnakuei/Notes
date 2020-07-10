# global 範例

缺點

- 每個 vue 初始化時，都會一併初始化 mixins !
- IDE 可能無法辨識

## [建立要共用的 ts](./local%20範例一.md#建立要共用的%20ts)

## main.ts

```ts
import Vue from 'vue'
import Vuex from 'vuex'
import App from './App.vue'
import router from './router'
import Mixin01 from "@/mixin/mixin01";  // 2

Vue.config.productionTip = false

export const eventBus = new Vue()

Vue.use(Vuex)
Vue.mixin(Mixin01)   // 1

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')

```
