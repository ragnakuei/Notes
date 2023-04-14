# debounce 範例

```html
<div>
    時間差在 1s 內的呼叫，只會得到一個結果
</div>

<button id="btnA" type="button">A</button>
<button id="btnB" type="button">B</button>

<script>
    document.getElementById('btnA').addEventListener('click', () => {
        console.log('click btnA');
        debounce(() => {
            console.log('A');
        }, 1000)
    });
    document.getElementById('btnB').addEventListener('click', () => {
        console.log('click btnB');
        debounce(() => {
            console.log('B');
        }, 1000)
    });
    
    // debounce 函數的實作
    let debounceTimerId;
    function debounce(func, delay) {
        if (debounceTimerId) {
            clearTimeout(debounceTimerId);
        }
        debounceTimerId = setTimeout(func, delay);
    }
</script>
```
