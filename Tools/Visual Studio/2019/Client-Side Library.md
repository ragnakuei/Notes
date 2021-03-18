# Client-Side Library

步驟

1. Client-Side Library
   1. 在專案上面
   2. 按下滑鼠右鍵
   3. 移至 Add
   4. 點擊 Client-Side Library
2. 開啟 Client-Side Library 視窗
   1. Provider - 代表下載套件的 cdn 來源
   2. Library - 可以輸入關鍵用，會有 autocomplete 顯示搜尋結果
      - 顯示格式 `套件名@版號`，例：`vue@3.0.6`
   3. Target Location - 檔案存放路徑
      - 預設會指向 /wwwroot/lib/
   4. 按下 Install 來執行上述的設定動作
3. vs 會自動建立 libman.json 檔案
   - 會記錄專案內 Client-Side Library 內的 library 及 provider
4. 如果 Client-Side Library 在 Library Folder 內的檔案有遺漏
   1. 可以在 libman.json 檔案上，按下滑鼠右鍵
   2. 點擊 `Client-Side Libraries`
   3. 就會還原所有 Client-Side Library 的檔案了 !
