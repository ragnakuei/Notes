# ng udpate

1. 執行 ng update

1. 依照上述的建議, 執行 ng update [套件]

1. 確認是否需要修正 vulnerabilities

---

## 修正漏洞的方式

- npm install - 可用來確認是否有 vulnerabilities

- npm audit  - 可用來確認是否有 vulnerabilities

- npm audit fix - 修正 vulnerabilities

如果上面的指令無效，執行以下的指令

- 執行 npm audit fix --force

如果上面的指令無效，可試著執行以下的指令

- npm i -f - 強制更新。需要 double checkout 是否會有問題

## 如果 npm audit 顯示沒有 vulnerabilities 需要修正，而 npm install 判斷需要修正 vulnerabilities

就建議執行以下步驟：

1. 刪除 package-lock.json

1. 執行 npm install

