# CSP 注意事項

通常比較要注意的是 style tag

最簡單的方式就是用 style + nonce 來做

```js

window.customElements.define('test', class extends HTMLElement {

    constructor() {
        super();

        this.attachShadow({ mode: 'open' });
        this.shadowRoot.innerHTML = `
<style nonce="123">
</style>
`
    }

});
```