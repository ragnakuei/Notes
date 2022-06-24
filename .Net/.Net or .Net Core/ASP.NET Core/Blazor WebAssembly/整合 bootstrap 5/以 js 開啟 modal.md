# 以 js 開啟 modal

情境：
1. HttpClientService 跟後端溝通時，如果發生錯誤後，將錯誤訊息傳至 MainLayout.razor 中的 Modal 中
1. Modal 以 Bootstrap 5 Modal 將錯訊息顯示出來 !

架構

1. Modal Component 訂閱 ModalService.Show() 以開啟 Modal
1. HttpClientService 發生錯誤時，呼叫 ErrorStore.ErrorOccurred()
1. 將錯誤訊息擷取出來後，呼叫 ModalService.Show()
1. 