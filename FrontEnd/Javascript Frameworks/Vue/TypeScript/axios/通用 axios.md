# 通用 axios

```ts
import Vue from 'vue';
import axios, { AxiosStatic } from 'axios';

axios.defaults.baseURL = 'http://192.168.1.225:8088';
Vue.prototype.$axios = axios;
declare module 'vue/types/vue' {
    interface Vue {
        $axios: AxiosStatic;
    }
}
```
