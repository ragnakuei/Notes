# record

跟 class 使用相同的結構，但特性與 class 不同

特性

-   immutable
-   依照 Properties 的值相同而相同
    -   如果 Properties 內包含了 class，則該 class 必須為 reference 相同，才會被視為相同

-   應用
-   放到 HashSet 中，可以省去做重複判斷
-   放到 Dictionary<Key, Value> 的 Key 時，可做更多的變化
