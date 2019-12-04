# RowNumber 的邏輯

- Base 1

  1. 在 Table 往右加一欄
  1. 資料內容以運算式呈現 `=RowNumber(Nothing)`
  1. 就會看到 RowNumber 會以 1 開始顯示

- Group 的前提下，RowNumber 等於所有資料筆數

  1. 在帶有 Group 欄位的 Table 往左加一欄
  1. 資料內容以運算式呈現 `=RowNumber(Nothing)`
  1. 就會看到 RowNumber 只會顯示總資料筆數

  