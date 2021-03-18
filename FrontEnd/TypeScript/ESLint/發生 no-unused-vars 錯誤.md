# 發生 no-unused-vars 錯誤

在 ts 中，已明確宣告，並確實使用指定的型別

但編譯時，仍然會出現 `'xxx' is defined but never used  no-unused-vars` 的錯誤

暫時的解決方式：

1. 開啟 package.json
2. 找到 eslintConfig > rules
3. 加上 "no-unused-vars": "off" 來暫時關閉，就可以了