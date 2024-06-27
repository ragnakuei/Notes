# 自訂 quick action 動作

參考資料：[【Unity】string.Format を ZString.Format に置換する ReSharper の Quick-Fixes を作成する](https://baba-s.hatenablog.com/entry/2020/05/11/090000)

簡單說就是從 resharper 定義設定後，再匯出設定檔，再匯入到 Rider 中。

[resharper 定義設定](https://www.jetbrains.com/help/resharper/Navigation_and_Search__Structural_Search_and_Replace.html)

### 透過既有的語法來新增

- 新增 keymap，action id 為 ReSharper_StructuralSearchSearch 
- 反白選擇要做成 quick action 的程式碼
- 觸發 action ReSharper_StructuralSearchSearch
- 就會出現 Search with Pattern 的視窗
- placeholder
  - 只要用 $$ 包住的字串，就會被當作 placeholder
- 按下 Save
- 之後就可以在 quick action 中找到剛剛新增的 quick action

重新編輯
- Reshapear > Options > Custom **Patterns**