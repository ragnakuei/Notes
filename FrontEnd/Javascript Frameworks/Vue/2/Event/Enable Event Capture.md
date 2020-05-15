# Enable Event Capture

## 範例

### Not Enable Event Capture

未開啟 Event Capture 的情況

以下範例為避免 Event Bubble 的混淆，所以內層 Div 先加上 `.stop`

```html
<div @click="onClickOuterDiv">
    Div Outer
    <div @click.stop="onClickInnerDiv">
        Div Inner
    </div>
</div>
```

### Enable Event Capture

在外層 click 事件加上 .`capture`

```html
<div @click.capture="onClickOuterDiv">
    Div Outer
    <div @click.stop="onClickInnerDiv">
        Div Inner
    </div>
</div>
```

在 Click Div Inner 時，就會觸發 Event Capture 了 !