# rules

參考資料

-   [Rules](https://github.com/NLog/NLog/wiki/Configuration-file#rules)

會依序從上而下套用規則，所以順序上極為重要

attribute find = true 也極為重要 !

|          |                                                        |
| -------- | ------------------------------------------------------ |
| name     | 日誌來源的名稱(允許使用通配符號\*)                     |
| minlevel | 設定符合該規則的最低級別                               |
| maxlevel | 設定符合該規則的最高級別                               |
| level    | 設定符合該規則的特定級別                               |
| levels   | 設定符合該規則的級別列表，用逗號分隔                   |
| writeTo  | 設定符合該規則的日誌要寫入的 target 列表，用逗號分隔   |
| final    | 設定符合該規則的條件為最後一個規則，後面的規則不再檢查 |
