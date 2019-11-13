# 技術分享 Angular + ASP.NET Web API 2

## Angular

1. [環境需求](https://angular.io/guide/setup-local)

    - Node.js 10.9.0 以上
    - npm (Node Package Manager)

1. 環境安裝

    目前可以透過 nvm (Node Version Manager) 來安裝並切換要使用的 Node.js 版本

    - 安裝 nvm

        - 至[官網](https://github.com/coreybutler/nvm-windows/releases)下載 nvm-setup.zip
        - 安裝 nvm
        - 安裝完畢後，輸入指令 nvm version 確認已安裝成功

    - 透過 nvm 安裝 Node.js

        - nvm install 10.9.0 - 會一併安裝 npm

    - 使用指定的版本的 Node.js

        - nvm use 10.9,0
        - 可透過 nvm list 來確認目前使用的 Node.js 版本

1. 安裝 [Angular CLI](https://cli.angular.io/)

    - npm install -g @angular/cli

1. 建立 Angular 專案

    - ng new my-app

1. 執行網站

    - ng serve

## 發佈 Angular

- [手動發佈](https://angular.io/guide/deployment#basic-deployment-to-a-remote-server)

    1. 執行 ng build --prod
    1. copy dist/my-app 內所有檔案至 iis 中
    1. 瀏覽網站，確認可顯示

- 手動發佈至本機指定資料夾

    1. 執行 ng build --prod --outputPath=C:\inetpub\web2

        > 注意： 會直接刪除 C:\inetpub\web2 資料夾。inetpub 需要有執行人員的權限，即使該人員屬於 Admiinistrators 的權限也不夠。

    1. 瀏覽網站，確認可顯示

## 參考資料

- [Angular Versioning and Releases](https://angular.io/guide/releases)
- nvm 常用指令

    | 指令 | 功能  |
    | ---- | ----- |
    | nvm list | 列出本機可選的 Node.js 版本 |
    | nvm list available | 列出目前可用的 Node.js 版本 |
    | nvm install 版號 | 安裝指定版號的 Node.js |
    | nvm use 版號 | 本機使用指定版號的 Node.js |

---

## ASP.NET Web API 2

- 建立 ASP.NET Web 應用程式
- 選擇空白範本
- 新增資料夾和核心參考，勾選 Web API
- 進階，取消勾選 HTTPS
