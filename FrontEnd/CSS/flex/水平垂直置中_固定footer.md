# 水平垂直置中_固定footer

其實就是把 footer 的 height 做為 wrapper 的 margin-bottom

```css
* {
    margin: 0;
}

html,
body {
    background: black;
    height: 100%;
}

.wrapper {
    font-size: 40px;
    font-family: Verdana;
    color: white;
    min-height: 100%;
    height: auto !important;
    margin-bottom: -20px;

    display: flex;
    align-items: center;
    justify-content: center;
}
    
.footer {
    height: 20px;
}
```