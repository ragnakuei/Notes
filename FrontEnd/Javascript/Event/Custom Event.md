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
