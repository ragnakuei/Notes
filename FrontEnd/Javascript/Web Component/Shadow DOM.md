# Shadow DOM


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