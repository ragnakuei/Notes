# 切換 donet core sdk 版本

先參考 [global.json](https://docs.microsoft.com/zh-tw/dotnet/core/tools/global-json) 的說明

在專案目錄下 找到/建立 `global.json` 檔案

檔案內的 sdk > version 就是該專案所指定使用的 sdk 版本

```
{
  "sdk": {
    "version": "2.2.200"
  }
}
```

修改完畢後，用 `dotnet --info` 驗証目前執行的 dotnet core sdk 版本 !

## global.json 有效範圍

有效範圍：`在該檔案下的所有子目錄`

## 建立 global.json 的方式

以指令 `dotnet new globaljson` 來建立
