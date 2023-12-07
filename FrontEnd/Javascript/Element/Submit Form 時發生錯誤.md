# Submit Form 時發生錯誤

## 情境 1 ： 在原生 modal 內 submit form，發生錯誤後，就被關閉了

### 原因

有相同的 submit button id 不在 modal 內，而是在 modal 外，所以當 submit & validation 失敗時，會去找到 modal 外的 submit button，而不是 modal 內的 submit button，所以就會發生錯誤。

其錯誤訊息為：
