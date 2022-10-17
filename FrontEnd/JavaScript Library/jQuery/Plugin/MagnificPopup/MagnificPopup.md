# [MagnificPopup](https://dimsemenov.com/plugins/magnific-popup/)

```js
$.magnificPopup.open({
    items: {
        src: '#popup1',
        type: 'inline',
    },
    closeOnBgClick: false,
    enableEscapeKey: false,
    showCloseBtn: false,
});
window.popup1 = $.magnificPopup.instance;
```

### 以 ifame 形式開啟

- type 設定為 iframe
- items.src 設定 iframe url


```js
function open_magnificPopup_iframe( iframe_url, closeCallBack ) {

    window.magnificPopup.closeCallBack = closeCallBack;

    setTimeout( () => {
        $.magnificPopup.open( {
            items: {
                src: iframe_url,
            },
            type: 'iframe',
            midClick: false, // 是否使用滑鼠中鍵
            closeOnBgClick: true,//點擊背景關閉視窗
            showCloseBtn: true,//隱藏關閉按鈕
            fixedContentPos: true,//彈出視窗是否固定在畫面上
            mainClass: 'mfp-fade',//加入CSS淡入淡出效果
            tClose: '關閉',//翻譯字串
            callbacks: {
                close: function() {
                    if( window.magnificPopup.closeCallBack ) {
                        window.magnificPopup.closeCallBack();
                    }
                }
            }
        } );
    }, 0 );
}
```