# query string 加密

- 好處
  - 避免使用者亂輸入資料
  - 仍然可以將該頁面的狀態放至 query string 中，方便使用者貼上給其他人
- 壞處
  - 使用者無法直接操作 query string，都必須經過 UI 上來觸發，會犧牲些許方便性 !
  - 一定要使用 Redirect 來重新套用 Url
    - RewritePath 目前看來做不到 !
