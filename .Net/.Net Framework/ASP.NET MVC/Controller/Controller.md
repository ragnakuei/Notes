# Controller

## 執行 Action 前預先處理程式

有以下幾種做法，以下以執行順序來條列

###  擴充 `ControllerActionInvoker`

- 需要 `BaseController` 的做法
  
  以團隊成員來說，幾乎不會有人會需要操作到這個做法，運用在團隊中，成本較小 !

###  以 `BaseController.OnActionExecuted()` 來處理

- 需要 `BaseController` 的做法
  
  以團隊成員來說，比較容易會有人需要操作這個做法，怕會有額外的成本 !

### 以 `ActionFilter.OnActionExecuting()` 來處理

