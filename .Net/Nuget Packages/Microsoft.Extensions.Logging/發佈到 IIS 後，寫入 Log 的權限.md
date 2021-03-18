# 發佈到 IIS 後，寫入 Log 的權限

假設 Log 檔要放在 /inetpub/{自訂的 web server 資料夾}/Logs/ 中

記得要把 Logs 資料夾權限開給目前正在操作的人員，該人員曾經操作過以下動作

-   建立 IIS WebSite
-   發佈 asp.net core 程式
-   複製上述程式至 /inetpub/{自訂的 web server 資料夾}/
-   建立 Logs 資料夾
-   [設定 Logs 資料夾權限](./../../../Windows/IIS/設定子資料夾權限.md)

目前不確定為何需要調整這樣的權限 !
