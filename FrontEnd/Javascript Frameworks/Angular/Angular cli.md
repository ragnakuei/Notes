# [Angular CLI](https://angular.io/cli)

## [new](https://angular.io/cli/new)

-   ng new MyApp --minimal=true 建立不包含測試的 App

## [generate](https://angular.io/cli/generate)

#### [module](https://angular.io/cli/generate#module)

-   ng g m Test
-   ng g m Order --flat

##### Options

| Options |                                            |
| ------- | ------------------------------------------ |
| --flat  | 將 module.ts 建立與 app.module.ts 同目錄下 |

#### component

-   ng g c Test --skip-tests=true

## [serve](https://angular.io/cli/serve)

-   ng serve --port 4201 以 port 4201 啟動網站
