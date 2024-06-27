原先問題：

> 一個頁面中，有二個 boostrap 4 modal component
> 但自己本機測試正常，但別人測試，會發生 backdrop 蓋掉原先的 modal content !

解決方式：

> 把二個 modal web component 移至外層 html，仍保留原先的引用順序

這樣測試就正常了 !

---

一個 modal 可以具有二個 z-index layer

1. backdrop
1. modal 內容
   而該 layer 都會依照組件的設定來給定 !

當一個頁面有二 modal 時，就要注意 z-index 引用順序
因為會有相同的 z-index layer 可能會互相干擾 !

建議讓先開啟的 modal 放在 html 上方 & 愈外層愈好
以減少雜訊 !

---

相同的 z-index 情況下，後者會蓋掉前者 !
故內層的 modal ，其 html 引用順序要放在外層 modal 下方 !
