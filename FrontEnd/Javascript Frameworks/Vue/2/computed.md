# computed

意圖是某些 property 計算後的結果

computed 雖然裡放的是 function 的宣告，但 binding 時，是指向 function name，而沒有 `()`

## 範例一

```html
<template>
    <div id="app">
        <p>{{ title }}</p>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                a: 'A',
                b: 'B',
            };
        },
        computed : {
            title() {
                return this.a + 'x' + this.b;
            }
        }
    };
</script>
```
