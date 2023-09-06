# Validation

[writing-custom-validation](https://blazor-university.com/forms/writing-custom-validation/)

[Blazor form validation](https://www.pragimtech.com/blog/blazor/blazor-form-validation/)


## 注意事項

- 如果指定了 OnSubmit，就不能指定 OnValidSubmit 或 OnInvalidSubmit !
- 如果指定了 OnSubmit，則必須經過 EditContext.Validate()，才會觸發 OnValidationRequested 事件 !
- OnInvalidSubmit 處理順序如下：
  - 觸發 OnValidationRequested 事件
  - 觸發 OnInvalidSubmit 事件
  - 給定 DataAnnotation 驗証錯誤訊息
- 觸發 OnValidationRequested 事件後，ValidationMessageStore 才會有資料 !
  - 目前找不到可以從 ValidationMessageStore 取出資料，再進行 加工/改寫 處理 !
- OnValidationRequested 事件
  - Blazor Server
    - 等於後端驗証，不會在 OnInput / OnChange 時，就立即觸發
- ValidationMessageStore 的處理資料順序如下：
  - 做 ValidationMessageStore.Clear()
  - 給定 OnValidationRequested 內指定的自訂驗証錯誤訊息
  - 給定 DataAnnotation 驗証錯誤訊息



