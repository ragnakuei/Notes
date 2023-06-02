# Git Command

| git config                             | 說明                                                           |
| -------------------------------------- | -------------------------------------------------------------- |
| git config --global core.quotepath off | 讓 git command 支援顯示中文                                    |
| --global user.email user@Test.com      | 設定 global user 的 email，有設定過 email，才可以用 git commit |
| --global core.sshCommand "ssh -p 1234" | 修改連線至遠端的 port 為 1234                                  |

| git status | 說明                               |
| ---------- | ---------------------------------- |
| git status | 檢查目前的狀態，可能會有對應的提示 |

| git init | 說明                 |
| -------- | -------------------- |
| git init | 初始化目前所在的目錄 |

| git log                                    | 說明                                      |
| ------------------------------------------ | ----------------------------------------- |
| git log                                    | 顯示 commit 的歷程                        |
| git log --oneline                          | 只顯示每個 commit message 的第一行        |
| git log --oneline --author="Sherly"        | 顯示作者為 Sherly 的 commit 記錄          |
| git log --oneline --author="Sherly\|Eddie" | 顯示作者為 Sherly 或 Eddie 的 commit 記錄 |
| git log --oneline --grep="wtf"             | 查詢 commit message 包含 wtf 的 commit    |

| git checkout                                               | 說明                                                                                        |
| ---------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| git checkout                                               | 切換至指定的 branch                                                                         |
| git checkout -b <target-branch>                            | 從目前所在的 branch 建立 target-branch 並切換過去                                           |
| git checkout -b <target-branch> <source-branch>            | 從 source target 建立 target-branch 並切換過去                                              |
| git checkout --track <source-branch> -b <target-branch>    | 從 source target 建立 target-branch 並切換過去，同時設定 target-branch 要追縱 source-branch |
| git checkout --no-track <source-branch> -b <target-branch> | 從 source target 建立 target-branch 並切換過去，同時設定 target-branch 不要追縱             |
| git checkout -m xxxFile                                    | 還原 merge 時指定檔案的衝突                                                                 |

| git branch                              | 說明                                                |
| --------------------------------------- | --------------------------------------------------- |
| git branch                              | 列出本所 local branch                               |
| git branch -a                           | 列出本所 local / remote branch                      |
| git branch xxx                          | 從目前 branch 產生新的 branch xxx                   |
| git branch xxx yyy                      | 從 branch yyy 產生新的 branch xxx                   |
| git branch -d xxx                       | 刪除 branch xxx                                     |
| git branch -D xxx                       | 強制刪除 branch xxx                                 |
| git branch -m yyy                       | 將目前的 branch 重新命名為 yyy                      |
| git branch --set-upstream-to=origin/xxx | 設定目前的 branch 的 remote track branch origin/xxx |
| git branch --unset-upstream             | 設定目前 branch 不 track 遠端分支                   |

| git merge                          | 說明                                                                   |
| ---------------------------------- | ---------------------------------------------------------------------- |
| git merge <target-branch>          | 將 target-branch (可以是 local 也可以是 remote ) 併到目前所在的 branch |
| git merge --abort                  | 中止 merge 的動作                                                      |
| Git merge --squash <target-branch> | 將 target-branch 的所有變更合併套用至目前所在 branch，不會立即 commit  |

| git cherry-pick               | 說明                                   |
| ----------------------------- | -------------------------------------- |
| git cherry-pick [command sha] | 將指定的 commit 套用至目前的 branch 中 |
| git cherr-pick --abort        | 中止目前 cherry-pick 的動作            |

| git stash                 | 說明                                                     |
| ------------------------- | -------------------------------------------------------- |
| git stash list            | 列出所有 stash 的資料，各個項目會是以 stash@{x} 為其編號 |
| git stash push            | 暫存目前的資料                                           |
| git stash save            | 暫存目前的資料                                           |
| git stash push -m message | 指定訊息來暫存目前的資料                                 |
| git stash pop stash@{x}   | 套用指定的 stash 項目                                    |
| git stash apply stash@{x} | 套用指定的 stash 項目                                    |
| git stash drop stash@{x}  | 刪掉指定的 stash 項目                                    |
| git stash clear           | 刪除所有 stash 項目                                      |

| git reset        | 說明                         |
| ---------------- | ---------------------------- |
| git reset Head   | Unstage 已 Stage Files       |
| git reset --hard | 重置目前所有未 commit 的變更 |

| git diff                        | 說明                                               |
| ------------------------------- | -------------------------------------------------- |
| git diff <remote-branch> <file> | 以 local file 與指定的 branch 的同個 file 進行比對 |

| git fetch    | 說明                                          |
| ------------ | --------------------------------------------- |
| git fetch    | 至 remote track branch 把更新的內容同步至本機 |
| git fetch -p | 把遠端所有 branch 的狀況同步至 local          |

| git pull                 | 說明                            |
| ------------------------ | ------------------------------- |
| git pull                 | 可以視為 git fetch > git merge  |
| git pull --rebase        | 可以視為 git fetch > git rebase |
| git pull <remote-branch> | 可以視為 git fetch > git merge  |

| git push                                | 說明                                                                     |
| --------------------------------------- | ------------------------------------------------------------------------ |
| git push                                | 將目前的變更記錄 push 至 remote trach branch                             |
| git push                                | 將目前的變更記錄 push 至指定的 remote branch                             |
| git push -u <remote-branch>             | 將目前的變更記錄 push 至指定的 remote branch，並設定 track remote branch |
| git push --set-upstream <remote-branch> | 將目前的變更記錄 push 至指定的 remote branch，並設定 track remote branch |
| git push -d origin cat                  | 刪除 origin/cat branch                                                   |
| git push origin :cat                    | 刪除 origin/cat branch                                                   |
| git push origin --delete cat            | 刪除 origin/cat branch                                                   |

| git rebase                                               | 說明                                                                                                                                           |
| -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| git rebase <target-branch>                               | 將目前的 branch 接至 <target-branch> 上。 rebase 後的順序跟 commit 順序無關，而是以 目前 branch > target branch > 共同的來源 branch 的方式排列 |
| git rebase --root <source-branch> --onto <target-branch> | 將 <source-branch> 接至 <target-branch> 上。                                                                                                   |

| git remote                                                                   | 說明                         |
| ---------------------------------------------------------------------------- | ---------------------------- |
| git remote add origin https://github.com/ragnakuei/AngularMaterailDemo01.git | 設定遠端的 github repository |

| git bundle                              | 說明        |
| --------------------------------------- | ----------- |
| git bundle create \<fileName> \<branch> | create 範本 |
| git bundle create gitbungldTest master  |             |
|                                         |             |
|                                         |             |
