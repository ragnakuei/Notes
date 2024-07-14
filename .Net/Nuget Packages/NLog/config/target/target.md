# [target](https://github.com/nlog/NLog/wiki/File-target)

##nlog

包含了

-   layout
-   [layout renders](./Layout%20Renderers.md)
-   type
    - file
    - [database](./type/database%20範例%2001.md)

## 共通的 attributes

-   name
    用來被 rule 指定

-   layout
    此項 Log 記錄之格式

## fileName

windows:

如果以 `\` 開頭來指定檔案的話，就會是執行磁碟機下的根目錄

如果要用當前目錄，要改用 `.\`

max os:

如果以 `/` 開頭來指定檔案的話，就會是執行磁碟機下的根目錄

如果要用當前目錄，要改用 `./`
