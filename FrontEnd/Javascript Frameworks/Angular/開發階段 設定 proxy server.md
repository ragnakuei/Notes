# [開發階段 設定 proxy server](https://angular.io/guide/build#proxying-to-a-backend-server)

1. 在 src 內建立 `proxy.conf.json`
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
