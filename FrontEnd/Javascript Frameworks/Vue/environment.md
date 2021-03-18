# [environment](https://cli.vuejs.org/guide/mode-and-env.html)

共用的 environment variables 放在 `.env` 檔案中

mode = development 的 environment variables 放在 `.env.development` 檔案中

mode = production 的 environment variables 放在 `.env.production` 檔案中

在本機開發時，如果有變更上述列的檔案，要`重新執行 npm run serve`，並且在 browser 按下 `ctrl + F5`

## 變數命名規則

要以 `VUE_APP_` 開頭

## .env.development 範例

```
VUE_APP_ApiHost=https://localhost:5001/
```

然後在程式中，就可以用下面的方式來取用

```ts
this.baseUrl = process.env.VUE_APP_ApiHost;
```
