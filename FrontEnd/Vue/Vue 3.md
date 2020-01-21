# Vue 3

- [Vue 3](#vue-3)
  - [產生 Vue 專案](#%e7%94%a2%e7%94%9f-vue-%e5%b0%88%e6%a1%88)
    - [安裝 Vue Cli](#%e5%ae%89%e8%a3%9d-vue-cli)
    - [建立 vue 專案](#%e5%bb%ba%e7%ab%8b-vue-%e5%b0%88%e6%a1%88)
    - [執行開發階段 Server](#%e5%9f%b7%e8%a1%8c%e9%96%8b%e7%99%bc%e9%9a%8e%e6%ae%b5-server)
    - [最小化編譯成 Production 環境](#%e6%9c%80%e5%b0%8f%e5%8c%96%e7%b7%a8%e8%ad%af%e6%88%90-production-%e7%92%b0%e5%a2%83)
    - [Lint 檢查](#lint-%e6%aa%a2%e6%9f%a5)
  - [結構](#%e7%b5%90%e6%a7%8b)
  - [Lifecycle](#lifecycle)

---

此做法未整合 WebPack，所以 index.html 會被加上許多的 js !

如需整合 WebPack，請參考[這裡](./搭配%20WebPack%20建立%20Vue%20專案.md)

---

## 產生 Vue 專案

### 安裝 Vue Cli

> npm install -g @vue/cli@3.0.5

> vue --version

### 建立 vue 專案

> vue create `[project name]`

> project name 要全部小寫

### 執行開發階段 Server

> npm run serve

### 最小化編譯成 Production 環境

會將資料輸出至 dist 資料夾中

> num run build

### Lint 檢查

> npm run lint

---

## 結構

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

## [Lifecycle](https://vuejs.org/v2/guide/instance.html#Lifecycle-Diagram)