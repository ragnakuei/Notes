# 有 modules 範例

[vuxe application structure](https://vuex.vuejs.org/guide/structure.html)

依照 store 的給定方式不同，分成二種語法

而使用 AuthModule 的方式都是一樣的

## 第一種

不用在 Vuex.Store() StoreOptions 中定義 modules

### Store

```ts
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
    strict: true,
});
export default store;
```

### VuexModule

-   在 Attribute 上給定 DynamicModuleOptions 中的 name、store、dynamic
    -   dynamic 要記得設定成 true
-   直接 export AuthModule，可以不用 export 繼承 VuexModule 的 class

```ts
import {
    Module,
    VuexModule,
    Mutation,
    Action,
    getModule,
} from 'vuex-module-decorators';
import store from '@/store';

@Module({
    name: 'Auth',
    store,
    dynamic: true,
})
class Auth extends VuexModule {
    public token = '';

    @Mutation
    public saveToken(token: string) {
        this.token = token;
    }
}

export const AuthModule = getModule(Auth);
```

---

## 第二種

### Store

/src/store/index.ts

-   要在 Vuex.Store() StoreOptions 中定義 modules
-   透過 getModule(VuexModule, Store) 給定 Store 來取得指定的 VuexModule，就可以透過強型別直接使用 Vuex 的功能

```ts
import Vue from 'vue';
import Vuex from 'vuex';
import { Auth } from '@/store/modules/Auth';
import { getModule } from 'vuex-module-decorators';

Vue.use(Vuex);

const store = new Vuex.Store({
    strict: true,
    modules: {
        Auth,
    },
});
export default store;

export const AuthModule = getModule(Auth, store);
```

### VuexModule

/src/store/modules/Auth

-   名稱一定要給

```ts
import {
    Module,
    VuexModule,
    Mutation,
    Action,
    getModule,
} from 'vuex-module-decorators';

@Module({ name: 'Auth' })
export class Auth extends VuexModule {
    public token = '';

    @Mutation
    public saveToken(token: string) {
        this.token = token;
    }
}
```
