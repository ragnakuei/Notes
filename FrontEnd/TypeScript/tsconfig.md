# [tsconfig](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html)


## paths 範例

### asp.net core mvc 範例

vue 的檔案放在 wwwroot/lib/vue/3.2.47/ 中

```json
{
  "compilerOptions": {
    "paths": {
      "@vue/*": [
        "./wwwroot/lib/vue/3.2.47/*"
      ],
      "vue": [
        "./wwwroot/lib/vue/3.2.47/vue.esm-browser.js"
      ],
      "/lib/*": [
        "./wwwroot/lib/*"
      ]
    }
  },
}
```

在 ts 中的 import 就可以這樣寫


```ts
// 對應至 paths @vue/* 的規則
import {createApp, onMounted, ref} from '@vue/vue.esm-browser.js';

// 對應至 paths vue 的規則
import {createApp, onMounted, ref} from 'vue';

// 對應至 paths /lib/* 的規則 ( 這項規則最適合 asp.net core mvc + ts，原因是要讓編譯後的 js 可以用 / 開頭來尋找 js 檔案 )
import {createApp, onMounted, ref} from '/lib/vue/3.2.47/vue.esm-browser.js';
```
