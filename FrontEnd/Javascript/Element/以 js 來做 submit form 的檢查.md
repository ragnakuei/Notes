# 以 js 來做 submit form 的檢查


```js
function Submit() {
    // 執行 form 的 validation，如果 validation 失敗，則會跳出錯誤訊息
    if( form.value.checkValidity() == false ) {
        form.value.reportValidity();
        return;
    }

    // do submit action
}

```