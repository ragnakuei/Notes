# [vue.config.js](https://cli.vuejs.org/config/#global-cli-config)

客制化設定檔，未給定皆以預設值執行

## publicPath

publicPath 所給定的值會放至 process.env.BASE_URL 中

用來設定目前 vue 網站的根目錄

```js
module.exports = {
    publicPath:
        process.env.NODE_ENV === 'production' ? '/production-sub-path/' : '/',
};
```
