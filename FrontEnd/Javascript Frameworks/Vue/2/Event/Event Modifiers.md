# Event Modifiers

| Modifier | 說明                                                 |
| -------- | ---------------------------------------------------- |
| .prevent | 等於 event.PreventDefault()，防止 DOM 本身預設的行為 |
| .stop    | 等於 event.stopPropagation()，防止 Event Bubble      |
| .capture | 進行 event Capture 動作                              |
| .self    | 只觸發自己本身的範圍，不包含子元素                   |
| .once    | 只觸發一次                                           |

