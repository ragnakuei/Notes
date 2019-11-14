# nvm

    注意：指定 node.js 版本時，就會一併安裝 npm

1. [下載 nvm](https://github.com/coreybutler/nvm-windows/releases)

1. 安裝 nvm

1. (Windows) 透過 nvm 安裝 node js

    以下是常用指令
    | 指令 | 說明 |
    | ------------------ | ---------------------- |
    | nvm list available | 列出可安裝的 node.js 版本 |
    | nvm list | 列出已安裝的 node.js 版本 |
    | nvm install latest | 安裝最新版的 node.js |
    | nvm install [node.js 版號] | 安裝 node.js，指定版號不用加 v |
    | nvm use [node.js 版號] | 使用指定版號的 node.js |

    安裝完畢後，將 C:\Program Files\nodejs\ 加到 Path 後，重新開機
輸入 node -v、npm -v 來驗証是否正確

參考資料

- http://trunk-studio.com/blog/nvm-for-windows/

1. (OSX) 透過 nvm 安裝 node js

    以下是常用指令
    | 指令 | 說明 |
    | ------------------ | ---------------------- |
    | nvm ls-remote | 列出可安裝的 node.js 版本 |
    | nvm install [node.js 版號] | 安裝 node.js，不指定版本就安裝最新的，指定版號不用加 v |
    | node use [node.js 版號] | 使用指定版號的 node.js |

    如果出現錯誤：

        nvm is not compatible with the npm config "prefix" option

    解決方式：

        輸入指令 - nvm use --delete-prefix v6.10.3

參考資料

- http://icarus4.logdown.com/posts/175092-nodejs-installation-guide