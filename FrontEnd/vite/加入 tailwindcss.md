# [加入 tailwindcss](https://tailwindcss.com/docs/guides/vue-3-vite)

#### 安裝 sass 

- 在專案目錄內，執行以下指令

    > npm install -D tailwindcss@latest postcss@latest autoprefixer@latest

- 建立設定檔 tailwind.config.js 及 postcss.config.js

    > npx tailwindcss init -p

#### tailwind.config.js

將 

```json
purge: [],
```

改為 

```json
purge: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
```

#### 新增 tailwindcss 引用

新增 main.css

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

main.js 引用 main.css

```js
import './main.css'
```
