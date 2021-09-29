# [開發階段 設定 proxy server](https://angular.io/guide/build#proxying-to-a-backend-server)

### 純 proxy

1. 在 src 內建立 `proxy.conf.json`

    - 注意：修改此檔案，必須重啟 ng serve

    ```json
    {
        "/api": {
            "target": "http://localhost:5000",
            "secure": false
        }
    }
    ```
1. 編輯 angular.json

    - 搜尋 `@angular-devkit/build-angular:dev-server`
    - 在該行下加上下面語法 `options` 的部份

    ```json
    },
        "serve": {
            "builder": "@angular-devkit/build-angular:dev-server",

            // 加上下面的 json
            "options": {
                "browserTarget": "angular:build",
                "proxyConfig": "src/proxy.conf.json"
            },
    ```
1. 後端主機設定 [CORS](../../../.Net/.Net%20or%20.Net%20Core/ASP.NET%20Core/CORS%20設定方式.md)

### 帶上 url rewrite

proxy.conf.json

```json
{
    "/api": {
        "target": "http://localhost:5000",
        "secure": false,
        "pathRewrite": {
            // 呼叫 api/index.html 的 request 轉為呼叫 target 的 index.html
            "api/index.html": "index.html"
        },
        "logLevel": "debug"
    }
}

```