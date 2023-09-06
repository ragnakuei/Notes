# 無法啟動 IIS Express (四)


某個相同檔名但不同的 namespace 的引用出現在多個 dll 中

例：兩者中都有類型 'ASP.usercontrol_xxxx_ascx'

至錯誤畫面提示的 (vs 後的 id 會不同，要視情況而定) C:\Users\[User]\AppData\Local\Temp\Temporary ASP.NET Files\vs\181a1b4b\6c388a60 中

以上例來說，把 vs/181a1b4b 的資料夾刪掉

然後再重新執行專案，在進入頁面的當下，才會動態編譯程式，產生該資料夾的內容

就可以了

