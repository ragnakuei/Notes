# debounce 範例

```html
<div>
    時間差在 1s 內的呼叫，只會得到一個結果 <br >
    連續點擊 A 按鈕，只會得到一個 A <br >
    連續點擊 B 按鈕，只會得到一個 B <br >
    二個按鈕是互相獨立的，不會互相影響 <br >
</div>

<button id="btnA"
        type="button">A</button>
<button id="btnB"
        type="button">B</button>

<script>
    document.getElementById('btnA').addEventListener('click', () => {
        console.log('click btnA');
        debounce('a',
        () => {
            console.log('A');
        }, 1000)
    });
    document.getElementById('btnB').addEventListener('click', () => {
        console.log('click btnB');
        debounce('b',
        () => {
            console.log('B');
        }, 1000)
    });

    // debounce 函數的實作
    window.debounceTimerIds = {};
    function debounce(key, func, delay) {
        // 先清掉尚未執行的 setTimeout
        if (debounceTimerIds[key]) {
            console.log('clearTimeout', key);
            clearTimeout(debounceTimerIds[key]);
        }

        // 設定最新的 setTimeout
        debounceTimerIds[key] = setTimeout(func, delay);
    }
</script>
```
