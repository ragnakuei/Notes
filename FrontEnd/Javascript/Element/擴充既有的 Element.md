# 擴充既有的 Element

關鍵：

1. 以類似 Web Component 繼承既有的 Element
1. 使用時，以 is 屬性指定擴充的 Element

### 範例：button

```html
<!DOCTYPE html>
<html lang="zh-Hant-TW">
    <head> </head>
    <body>
        <form>
            <div>
                <input type="text" name="name" value="name" />
            </div>

            <button id="btn" type="button" is="my-button">Click me</button>
            <button type="button" id="btnReset">Reset</button>
        </form>

        <script type="module">
            window.customElements.define(
                'my-button',
                class extends HTMLButtonElement {
                    connectedCallback() {
                        this._formDom = this.closest('form');
                        this._formDom.addEventListener('change', (e) => {
                            console.log('form status changed');
                            this._promptChanged = true;
                        });
                        this._formDom.addEventListener('reset', (e) => {
                            console.log('form reset');
                            this._promptChanged = false;
                        });

                        this.addEventListener('click', (e) => {
                            if (!this._promptChanged) {
                                return;
                            }

                            if (confirm('是否要繼續執行後續事件 ?')) {
                                console.log('繼續執行後續事件');
                            } else {
                                console.log('取消執行後續事件');
                                e.stopImmediatePropagation();
                            }
                        });
                    }

                    _promptChanged = null;
                },
                { extends: 'button' },
            );

            document.getElementById('btn').addEventListener('click', (e) => {
                console.log('成功執行 click', btn);
            });

            document
                .getElementById('btnReset')
                .addEventListener('click', (e) => {
                    document.querySelector('form').reset();
                });
        </script>
    </body>
</html>
```
