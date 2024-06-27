# 關閉 Git 自動 check 功能

-   [參考資料](https://www.jetbrains.com/help/rider/Settings_Version_Control_Git.html)

## 設定方式

Settings > Version Control > Git > `Explicitly check for incoming commits on remotes`

設定為 `Never`

## 緣由

當 git 是透過 ssh + 密碼來登入時，因為 Rider 本身沒有記錄密碼的功能 (不確定)

反而會導致持續的嘗試登入失敗

如果 git server 有設定登入失敗，就加入黑名單的功能

自動 check 的功能，反而造成了困擾 !
