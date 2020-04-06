# 無法啟動 IIS Express (二)

參考[這邊](https://dotblogs.com.tw/whd/2017/03/08/001714)的做法時，不管改到哪個 port，都還是無法啟動 IIS Express

## 解決方式：

### 大方向

> 就是刪除原本方案內的 IIS Express 設定檔案，重新建立同名 Web 專案，再以原 Web 專案下去用新的 port 來啟動

### 細節

- 關閉 Visual Studio
- 刪除與 .sln 檔同目錄下的 .vs 資料夾
- 將`無法啟動 IIS Express 的 Web 專案`改名
- 以 Visual Studio 開啟方案
- 建立 Web 專案，名稱與原`無法啟動 IIS Express 的 Web 專案`名稱一致
- 執行上述所建立之 Web 專案，確認要可以執行，並記錄 Port
- 關閉 Visual Studio
- 刪除上述所建立之 Web 專案
- 將原`無法啟動 IIS Express 的 Web 專案`名稱改回來
- 以 Visual Studio 開啟方案
- 將`無法啟動 IIS Express 的 Web 專案`所使用的 port 改成上面可以啟動的 port
- 刪除 .vs/`無法啟動 IIS Express 的 Web 專案`/config/applicationhost.config 設定檔中，原本無法建立 IIS Express WebSite 的 Site 資料
