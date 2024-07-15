# Custom Event

### 範例

```html
<div>
    <button type="button" id="btnReg">Register Event</button>
    <button type="button" id="btnTri">Trigger Event</button>
    <button type="button" id="btnUn">UnRegister Event</button>
</div>

<script>
    HTMLElement.prototype.addCustomEvent = function (eventName, callback) {
        this.addEventListener(eventName, callback);
    };

    HTMLElement.prototype.removeCustomEvent = function (eventName, callback) {
        this.removeEventListener(eventName, callback);
    };

    const btnReg = document.getElementById('btnReg');
    const btnTri = document.getElementById('btnTri');
    const btnUn = document.getElementById('btnUn');

    btnReg.addEventListener('click', function () {
        btnTri.addCustomEvent('myEvent', myEventCallback);
    });

    btnUn.addEventListener('click', function () {
        btnTri.removeCustomEvent('myEvent', myEventCallback);
    });

    function myEventCallback() {
        console.log('Triggered');
    }

    btnTri.addEventListener('click', function () {
        btnTri.dispatchEvent(new CustomEvent('myEvent'));
    });
</script>
```

### bug

發生過無法順利 remove > add 後，在 dispatchEvent 時觸發兩次的問題。

解決方法是在 addEventListener 時，先檢查是否已經有註冊過，若有則不再註冊。

```javascript
HTMLElement.prototype.addCustomEvent = function (eventName, callback) {
    if (!this.customEvents) {
        this.customEvents = {};
    }

    if (!this.customEvents[eventName]) {
        this.customEvents[eventName] = [];
    }

    if (this.customEvents[eventName].indexOf(callback) === -1) {
        this.customEvents[eventName].push(callback);
        this.addEventListener(eventName, callback);
    }
};
```
