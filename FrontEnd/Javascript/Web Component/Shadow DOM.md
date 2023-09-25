# Shadow DOM

特點
- 獨立的 DOM 結構
- 獨立的 CSS 結構
- 獨立的 JS 結構
- 獨立的事件結構
- 獨立的生命週期

### 範例

```html
<custom-element-01></custom-element-01>
<custom-element-01>1</custom-element-01>
<custom-element-01>2</custom-element-01>

<script>
    window.customElements.define('custom-element-01', class extends HTMLElement {
        
        shadowRoot = null;

        constructor() {
            super();
            
            // 如果這邊不用 shadowRoot，那麼 slot 內容會直接顯示出來，而達不到 shadow DOM 的效果
            this.shadowRoot = this.attachShadow({ mode: 'open' });
            this.shadowRoot.innerHTML = `
<div>
    Success !
    <slot></slot>
</div>
`
        }
    });
</script>
```