# 搭配 WebPack 建立 Vue 專案

- [搭配 WebPack 建立 Vue 專案](#%e6%90%ad%e9%85%8d-webpack-%e5%bb%ba%e7%ab%8b-vue-%e5%b0%88%e6%a1%88)
  - [步驟](#%e6%ad%a5%e9%a9%9f)
    - [安裝 vue cli 初始化套件](#%e5%ae%89%e8%a3%9d-vue-cli-%e5%88%9d%e5%a7%8b%e5%8c%96%e5%a5%97%e4%bb%b6)
    - [建立 vue 搭配 WebPack 專案](#%e5%bb%ba%e7%ab%8b-vue-%e6%90%ad%e9%85%8d-webpack-%e5%b0%88%e6%a1%88)
  - [升級](#%e5%8d%87%e7%b4%9a)
  - [參考資料](#%e5%8f%83%e8%80%83%e8%b3%87%e6%96%99)

---

vue init 產生的範本，要確認一下 vue 的版本

---

## 步驟

### 安裝 vue cli 初始化套件

> npm install -g @vue/cli-init

### 建立 vue 搭配 WebPack 專案

> vue init webpack `[project name]`

會再詢問以下問題，來建立 vue 專案

- ? Project name `project name`
- ? Project description `A Vue.js project`
- ? Author `Kuei Peng <ragnakuei@livemail.tw>`
- ? Vue build `standalone`
- ? Install vue-router? `Yes`
- ? Use ESLint to lint your code? `Yes`
- ? Pick an ESLint preset `Standard`
- ? Set up unit tests `No`
- ? Setup e2e tests with Nightwatch? `No`
- ? Should we run `npm install` for you after the project has been created? (recommended) `npm`

---

## 升級

> npm install eslint-plugin-vue

---

## 參考資料

- [使用適用於 Visual Studio 的 Node.js 工具建立 Vue.js 應用程式](https://docs.microsoft.com/zh-tw/visualstudio/javascript/create-application-with-vuejs)

- [手動建置一個Webpack-Vue的開發環境](https://devs.tw/post/60)