# footer 在頁面底部或內文底部

如果內文不滿一頁高，讓 footer 在底部
如果內文超過一頁，讓 footer 在內文底部

```css
body
    margin:0

    
.flex-wrapper 
  display: flex
  min-height: 100vh
  flex-direction: column
  justify-content: space-between

.container
    background-color:#eeeecf

.footer
    height:100px
    background-color:#eecfee
```

```html
<html>
    <head></head>
    <body>
        <div class="flex-wrapper">
            <div class="container">
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>
                <p>The content</p>

                <!-- 以下註解拿掉，就可以看出內容超過整頁高，footer 仍然在底部 -->
                <!--             <p>The content</p>
            <p>The content</p>
            <p>The content</p>
            <p>The content</p>
            <p>The content</p>
            <p>The content</p>
            <p>The content</p> -->
            </div>
            <div class="footer">The Footer</div>
        </div>
    </body>
</html>
```

