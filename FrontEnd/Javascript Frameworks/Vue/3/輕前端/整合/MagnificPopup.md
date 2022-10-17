# MagnificPopup

如果有以下需求：

- 其中一個視窗關掉後，要立即再開啟一個視窗
- 要以 closeCallBack 的方式，達到上述的要求

要使用相同設定檔來開啟視窗，否則關掉視窗的當下，會無法於短時間內開啟視窗 !
原因不明 !

```js
window.magnificPopup = {
    closeCallBack : null,
};

function open_magnificPopup(dom_id, closeCallBack) {
    
    window.magnificPopup.closeCallBack = closeCallBack;
    
    setTimeout(() => {
        $.magnificPopup.open({
            items: {
                src: '#' + dom_id //要自動播放的ID
            },
            type:'inline',
            midClick: false, // 是否使用滑鼠中鍵
            closeOnBgClick:true,//點擊背景關閉視窗
            showCloseBtn:true,//隱藏關閉按鈕
            fixedContentPos:true,//彈出視窗是否固定在畫面上
            mainClass: 'mfp-fade',//加入CSS淡入淡出效果
            tClose: '關閉',//翻譯字串
            callbacks: {
                close: function() {
                    if(window.magnificPopup.closeCallBack) {
                        window.magnificPopup.closeCallBack();
                    }
                }
            }
        });
    }, 0);
}
function close_magnificPopup() {
    $.magnificPopup.close();
}
```