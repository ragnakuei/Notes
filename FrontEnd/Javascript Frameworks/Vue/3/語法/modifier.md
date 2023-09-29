# modifier

有以下幾種 modifier

-   [Event Modifier](https://vuejs.org/guide/essentials/event-handling.html#event-modifiers)

    -   self
        -   只有當 event.target 是 element 自己時才會觸發
    -   stop
        -   阻止 event 冒泡
    -   prevent
        -   阻止 event 的預設行為
    -   once
        -   只會觸發一次

-   [Key Modifier](https://vuejs.org/guide/essentials/event-handling.html#key-modifiers)

    -   指的是 keydown / keyup event
    -   支援 keyCode
        -   例如：`keydown.13`、`keydown.27`
    -   同時也支援 a ~ z、0 ~ 9、F1 ~ F12、PageUp、PageDown、Home、End、Insert、Delete、Enter、Tab、Esc、Space、Up、Down、Left、Right
    -   同一個 keydown event 的不同 key code 會被視為不同的 key event, 可以分別監聽多個 key event
    -   如果 keydown.a 所指定的 function 中有清空 input 的動作，預設是無法清空的
        -   因為 keydown.a 會先執行，接著會再執行所要執行的動作 ( 也就是 input a 這個動作 )
        -   在 keydown.a 中加上 `.prevent` 來阻止要執行的動作後，就可以不會額外執行 input a 這個動作

-   [Mouse Button Modifier](https://vuejs.org/guide/essentials/event-handling.html#mouse-button-modifiers)

- [v-model Modifier](https://vuejs.org/guide/essentials/forms.html#modifiers)

    -   lazy
        -   在 change event 時才會更新資料
    -   number
        -   將資料轉成數字
    -   trim
        -   移除頭尾空白
