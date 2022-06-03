# 讓 import 支援 @

[參考資料](https://stackoverflow.com/questions/66043612/vue3-vite-project-alias-src-to-not-working)

vite.config.js

```js
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// 加下面的設定
import { fileURLToPath, URL } from "url";

export default defineConfig({
  plugins: [vue()],

  // 加下面的設定：@ 則代表 src 資料夾路徑
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
})
```

範例

```js
import TeamMembersService from "@/services/TeamMembersService";
```