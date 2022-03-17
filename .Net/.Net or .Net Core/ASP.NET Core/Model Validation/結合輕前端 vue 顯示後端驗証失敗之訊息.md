# 結合輕前端 vue 顯示後端驗証失敗之訊息


### 範例說明

[範例一連結](https://github.com/ragnakuei/ModelStateValidationToVue/blob/master/ModelStateValidationToVue/Views/Home/Edit1.cshtml)
- 後端驗証，不透過 jQuery
- 後端收到 request 並對 Model 做驗証後
- 透過 `ModelStateErrorMessageGrouperService` 將 Model State Error Key 整理成跟物件同樣的結構
- 接下來透過 `ErrorMessageDtoToJsonObjectService` 將上述的結構，轉成 `JsonObject` 的結構
- 當驗証失敗時，Response 就會把 `JsonObject` 的資料回傳給前端
- 前端 vue 對 js object 進行判斷與解析，將驗証失敗的錯誤訊息顯示出來

[範例二連結](https://github.com/ragnakuei/ModelStateValidationToVue/blob/master/ModelStateValidationToVue/Views/Home/Edit2.cshtml)
- 後端驗証，不透過 jQuery
- 後端收到 request 並對 Model 做驗証後
- 延用 Model State Error Key 的資料結構
- 當驗証失敗時，Response 就會把 `Dictionary<string, List<string>>` 的資料回傳給前端
- 前端 vue 對 js object 進行判斷與解析，將驗証失敗的錯誤訊息顯示出來
- 比範例一的維護成本低
