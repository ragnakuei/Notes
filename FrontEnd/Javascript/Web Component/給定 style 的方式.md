# 給定 style 的方式

如果是 shadow dom 的話，因為會是獨立的 dom 結構，所以要給定 style 就必須要在 shadow dom 內給定

方式有以下幾種：

### 方式一

在 shadow dom 內給定 style tag

這個寫法要注意其 CSP 的設定，如果是用 nonce 的話，要在 style tag 內加上 nonce


```js
window.customElements.define('test', class extends HTMLElement {

    constructor() {
        super();

        this.attachShadow({ mode: 'open' });
        this.shadowRoot.innerHTML = `
<style>
    // TODO
</style>
`
    }

});

```


### 方式二

在 shqadow dom 內給定 style tag

```js
window.customElements.define('test', class extends HTMLElement {

    constructor() {
        super();

        this.attachShadow({ mode: 'open' });
        this.shadowRoot.innerHTML = `
    }

    connectedCallback() {
        const style = document.createElement('style');
        style.innerHTML = `
            .my-div {
                color: blue;
                font-size: 24px;
            }
        `;
        this.shadowRoot.appendChild(style);
    }
}
```


### 方式三

在 shadow dom 內給定 link tag

```js
window.customElements.define('test', class extends HTMLElement {

    constructor() {
        super();

        this.attachShadow({ mode: 'open' });
        this.shadowRoot.innerHTML = `
`;
    }


    connectedCallback() {
        const link = document.createElement('link');
        link.setAttribute('rel', 'stylesheet');
        link.setAttribute('href', 'https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css');
        this.shadowRoot.appendChild(link);
    }

});        
```

