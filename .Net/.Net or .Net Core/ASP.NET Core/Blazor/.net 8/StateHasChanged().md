# StateHasChanged()

呼叫這個會導致整個畫面重新 Render

---

如果該 Component 內有引用其他 Component 時，該 Component 亦會被重新初始化 !

> 觀察方式：在 child component 上宣告一個 預設建構子，把中斷點下在預設建構子上，就可以觀察出來 !

值的同步上，最好還是用 Parameter ，不要直接用 @ref 來取得 child component 變數來更新欄位資料 !
