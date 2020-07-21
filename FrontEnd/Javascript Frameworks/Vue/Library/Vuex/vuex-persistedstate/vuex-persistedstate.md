# vuex-persistedstate

可以讓 vuex 裡面的資料不隨著 refresh page 而消失

以下是全域設定保留資料的地方，要確實保留資料，還需要看 module 的設定

- [typscript 範例](../../../TypeScript/Vuex/vuex-persistedstate/有%20modules%20範例.md)


## 改用 local storage

```ts
createPersistedState()
```

或

```ts
createPersistedState({ storage: window.localStorage })
```

## 將 local storage 加密

```ts
import { Store } from "vuex";
import createPersistedState from "vuex-persistedstate";
import SecureLS from "secure-ls";
var ls = new SecureLS({ isCompression: false });
 
// https://github.com/softvar/secure-ls
 
const store = new Store({
  // ...
  plugins: [
    createPersistedState({
      storage: {
        getItem: (key) => ls.get(key),
        setItem: (key, value) => ls.set(key, value),
        removeItem: (key) => ls.remove(key),
      },
    }),
  ],
});
```

## 改用 sessionStorage

```ts
createPersistedState({ storage: window.sessionStorage })
```

## 改用 cookie

```ts
import { Store } from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import * as Cookies from 'js-cookie'

const store = new Store({
  // ...
  plugins: [
    createPersistedState({
      storage: {
        getItem: key => Cookies.get(key),
        setItem: (key, value) => Cookies.set(key, value, { expires: 3, secure: true }),
        removeItem: key => Cookies.remove(key)
      }
    })
  ]
})
```
