# 找出控制項預設的 Binding 方式

- 使用 Rider
- 移至指定控制項 (此範例為 `TextBox`)
- 找到 Binding Property (此範例以 `Text` 為 Sample)
- 按下 F12 (Go To > Declaration Or Usages)
- 找到以下條件的 Property (此範例為 `TextProperty`)
  - 以 Binding Property 開頭，以 Property 結尾
  - 回傳類型為 `DependencyProperty`
  - 宣告屬性為 `Static`
- 該 Property 以 DependencyProperty.Register() 宣告
- 找出 DependencyProperty.Register() 中的最後一個參數 (範例例為 `UpdateSourceTrigger.LostFocus`)
