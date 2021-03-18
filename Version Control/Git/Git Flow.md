
參考資料
- https://gitbook.tw/chapters/gitflow/why-need-git-flow.html
- https://gitbook.tw/chapters/gitflow/using-git-flow.html
- https://ihower.tw/blog/archives/5140
- http://www.takobear.tw/2014/02/15/bear-git-flow-sourcetreegit-flow/
- https://www.git-tower.com/learn/git/ebook/cn/command-line/advanced-topics/git-flow

branch name | 說明
------------|------
master      | 與 production  一模一樣的版本
hotfixes    | 用來處理緊急必須立刻修改的 branch。會從 master 分支出來，完成後 merge 回 master 和 develop" merge 至 master 及 develop，不會立即 merge 至 release。
release     | 修 bug 用，修正後，merge 回 master 和 develop
develop	    |
feature	    | 用來開發新功能用，可以同時有多條 feature branches

![Alt text](_images/git-flow-01.png)

