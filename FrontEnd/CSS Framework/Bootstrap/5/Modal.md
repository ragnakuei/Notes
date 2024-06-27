### 使用 js 開啟 modal && 需要使用 object 來儲存 modal instance 時

要注意

> 就算原先的 html 經過刪除後，bootstrap 5 js 仍可以透過該 modal instance 重新將該 html 生成回來 !

有些 SPA 架構下，會在初始化時將 html 刪除
之後使用 new bootstrap.Modal(dom) 時，會因為找不到該 dom 而出現下面的錯誤訊息

> Cannot read properties of undefined (reading 'classList')

刪除 或 不在使用該 modal instance 時
最好立即對該 modal instance 做 .dispose() & delete 該 object property

### 具有 auto width 功能

這個做法會導致 modal-body 過長時，會無法完整顯示內容 !
畢竟 bootstrap 5 預設的設計不支援 auto width 功能 !

取消設定 .modal-sm / .modal-lg / modal-xl
再給定以下 css ( 會覆蓋 Default Size 設定 )

```css
.modal.show {
    display: flex !important;
    justify-content: center;
    align-items: center;
}

.modal-dialog {
    max-width: 100 %;
    width: auto !important;
}
```
