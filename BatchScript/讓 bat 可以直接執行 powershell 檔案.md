# 讓 bat 可以直接執行 powershell 檔案

因為要讓 ps1 可以直接執行，會需要額外的調整，其中一個簡便的方式，就是透過 bat 去執行 ps1

## 至 PowerShell 中，調整 Execution Policy 為允許本機使用

> set-executionpolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

## 建立 bat 檔

格式

> powershell.exe -command "& 'ps1檔絕對路徑'"

範例

> powershell.exe -command "& 'C:\Users\Kuei\Documents\Kuei\Wifi\A.ps1'"
