# [splice](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice)

- splice() 回傳的是處理的 item，不要用 `ary = ary.splice(x, 1)` 這種語法


## overloads

- splice(index)
  - 刪除含 index 以後的所有 item

- splice(index, replaceCount)
  - 刪除含 index 以後的 count 數量的 items
  - replaceCount 如果為 0，就可視為只有 insert 的動作

- splice(index, replaceCount, insertItem)
  - 刪除含 index 以後的 count 數量的 items
  - replaceCount 如果為 0，就可視為只有 insert 的動作
  - 插入 insertItem 至 index

