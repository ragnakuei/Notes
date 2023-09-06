# 在 osx 上登入 github 

1. 至 Github 帳號設定頁面，點選左方最下面 Developer settings
1. 點選 Personal access tokens
1. 點選 Generate new token 按鈕，選擇 Fine-grained tokens 或 Tokens (classic) 都可以
1. 設定好權限後，點選 Generate
1. token 建立後，複製下來
1. 在 osx 的 terminal 中，以 git cli clone 任一 repository，其中密碼欄位貼上 token，要可以正常下載下來
1. 在 osx 的 terminal 中輸入 `git config --global credential.helper osxkeychain`
1. 完成