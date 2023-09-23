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
        constructor() {
            super();
            
            const shadowRoot = this.attachShadow({ mode: 'open' });
            shadowRoot.innerHTML = `
<div>
    Success !
    <slot></slot>
</div>
`
        }
    });
</script>
```