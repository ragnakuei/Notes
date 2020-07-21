# vuex-persistedstate

vuex 裡面的資料不隨著 refresh page 而消失

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
