# [支援 typescript](https://vitejs.dev/guide/features.html#typescript)

- vite 不提供 ts 的型別檢查，可以使用以下方式
  - 透過 IDE
  - 透過 `tsc --noEmit` 檢查 ts 檔
  - 透過 `vue-tsc --noEmit` 檢查 vue 檔

### 建立 tsconfig.json 設定檔

- tsconfig.json 可從 vue cli 建立的可使用 ts 的範本串取出，再進行下面的修改

```json
{
  "compilerOptions": {
     
    // 加上下面這一行 
    "isolatedModules": true,

    "useDefineForClassFields": false,
    "target": "esnext",
    "module": "esnext",
    "strict": true,
    "jsx": "preserve",
    "importHelpers": true,
    "moduleResolution": "node",
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "sourceMap": true,
    "baseUrl": ".",

    // 修改為 指向 vite
    "types": ["vite/client"],
    
    "paths": {
      "@/*": ["src/*"]
    },
    "lib": ["esnext", "dom", "dom.iterable", "scripthost"]
  },
  "include": [
    "src/**/*.ts",
    "src/**/*.tsx",
    "src/**/*.vue",
    "tests/**/*.ts",
    "tests/**/*.tsx"
  ],
  "exclude": ["node_modules"]
}
```


### vue 檔 script 改為 lang="ts"

這個部份的修改就看自己的選擇

- 原本 vue 檔內容如下：

    ```html
    <script setup>
    import { ref } from 'vue'

    defineProps({
    msg: String
    })

    const count = ref(0)
    </script>
    ```

- 可以改回 script lang=ts 的型式

    ```html
    <script lang="ts">
    import { defineComponent, ref } from "vue";

    export default defineComponent({
    name: "HelloWorld",
    props: {
        msg: String,
    },
    setup() {
        const count = ref(0);

        return {
        count,
        }
    }
    });
    </script>
    ```
