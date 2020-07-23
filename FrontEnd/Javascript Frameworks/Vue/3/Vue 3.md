# [Vue 3](https://github.com/vuejs/vue-next)

此做法未整合 WebPack，所以 index.html 會被加上許多的 js !

如需整合 WebPack，請參考[這裡](./搭配%20WebPack%20建立%20Vue%20專案.md)

[升級 Vue 3 前，你必須要知道的改動](https://medium.com/peerone-technology-皮偶玩互動科技/升級-vue-3-前-你必須要知道的改動-5891a297dbe2)


---

## 產生 Vue 專案

### 安裝 Vue Cli

> npm install -g @vue/cli@3.0.5

> vue --version

### 建立 vue 專案

    project name 要全部小寫

> vue create `[project name]`

### 執行開發階段 Server

> npm run serve

### 最小化編譯成 Production 環境

    會將資料輸出至 dist 資料夾中

> npm run build

### Lint 檢查

> npm run lint

---

## 資料夾結構

- public

  - index.html
    - 最上層的入口
    - `BASE_URL` - 會被置換成 app 所在路徑，該變數可能來源是 `process.env.BASE_URL`
    - `</head>` 及 `</body>` - 都會在編譯後加上引用的 js
    - 唯一的 `<div>` - 被 Vue 指定要動態產生程式碼的地方
  - favicon.ico

- src

  - 存放 vue 專案的地方
  - main.js

    - vue 的起始設定檔

    起始 component 為 App.Vue，放進 index.html 的 id 為 app 中來呈現

    ```js
    new Vue({
      render: h => h(App)
    }).$mount("#app");
    ```

  - App.vue
    - 預設為起始 Component
    - `<template>` - 該 component 的 html
    - `<script>` - 該 component 的 js
    - `<style>` - 該 component 的 style
    - 如果該 component 內，要直接呼叫其他 component 時，要先 import 再使用

    ```html
    <template>
    <div id="app">
        <img alt="Vue logo" src="./assets/logo.png" />
        <HelloWorld msg="Welcome to Your Vue.js App" />
    </div>
    </template>

    <script>
    import HelloWorld from "./components/HelloWorld.vue";

    export default {
        name: "app",
        components: {
            HelloWorld
        }
    };
    </script>

    <style>
    #app {
        font-family: "Avenir", Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-align: center;
        color: #2c3e50;
        margin-top: 60px;
    }
    </style>
    ```
