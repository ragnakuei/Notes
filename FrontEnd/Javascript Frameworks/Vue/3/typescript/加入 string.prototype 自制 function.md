# 加入 string.prototype 自制 function

#### 範例一

新增檔案 string.extensions.ts 至 src 目錄中

```ts
interface String {
    to_yyyy_MM_dd(this: string): string;
    to_hh_mm(this: string): string;
}
```

新增檔案 string.extensions.js 至 assert/js/ 目錄中

```js
// 將後端給的日期資料 yyyy/MM/ddTHH:mm:ss 轉成 yyyy-MM-dd
String.prototype.to_yyyy_MM_dd = function() {
    return this.split('T')[0].replace('/', '-');
}

// 將後端給的日期資料 HH:mm:ss 轉成 HH:mm
String.prototype.to_hh_mm = function(){

    // console.log(this);

    return this.includes('T')
        ? this.split('T')[1].substring(0, 5)
        : this.substring(0, 5);
}
```

main.ts 引用 string.extensions.js

```ts
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './assets/css/global.css';

// 增加這一行
import './assets/js/string.extensions.js';

createApp(App).use(router).mount('#app')
```