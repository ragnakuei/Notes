# 想想更好的 web component 寫法


## 第一種寫法

如果不借助 DOMPurify 的話，會有 XSS 的風險，這是因為我們直接將 HTML 字串插入到 DOM 中。

```js
const jsClass = class extends HTMLElement {
  async connectedCallback() {
    this.innerHTML = `
            <form container>
            </form>
        `;

    this._containerDom = this.querySelector("[container]");

    this._list = await this._fetchList();
    this._renderList();
  }

  _containerDom = null;

  _list = [];

  _fetchList = async () => {
    // Fetch the list from an API or other source
    return []; // Placeholder return value
  };

  _renderList = () => {
    const html = this._list
      .map((item) => {
        const idFor = "input" + item.id;
        return `
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="${idFor}">Description</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="${idFor}" value="${item.value}">
                    </div>
                </div>
            `;
      })
      .join("");
    this._containerDom.innerHTML = html;
  };
};

customElements.define("wc-component", jsClass);
```

## 第二種寫法

```js
const jsClass = class extends HTMLElement {
    connectedCallback() {
        this.innerHTML = `
            <form container>
            </form>
        `;

        this._containerDom = this.querySelector('[container]');

        this._list = await this._fetchList();
        this._renderList();
    }

    _containerDom = null;

    _list = [];

    _fetchList = async () => {
        // Fetch the list from an API or other source
        return []; // Placeholder return value
    }

    _renderList = () => {

        const rowDoms = this._list.map((item ) => {

                const rowDom = document.createElement('div');
                rowDom.classList.add('row', 'mb-3');

                const idFor =  'input' + item.id;

                const labelDom = document.createElement('label');
                labelDom.classList.add('col-sm-2', 'col-form-label');
                labelDom.setAttribute('for', idFor);
                labelDom.innerText = 'Description';
                rowDom.appendChild(labelDom);

                const colDom = document.createElement('div');
                colDom.classList.add('col-sm-10');

                const inputDom = document.createElement('input');
                inputDom.setAttribute('type', 'text');
                inputDom.classList.add('form-control');
                inputDom.setAttribute('id', idFor);
                inputDom.value = item.value;

                colDom.appendChild(inputDom);
                rowDom.appendChild(colDom);

                return rowDom;
        });

        this._containerDom.replaceChildren(...rowDoms);
    }

}

customElements.define('wc-component', jsClass);
```

## 第三種寫法

目前


```js

const jsClass = class extends HTMLElement {
    connectedCallback() {
        this.innerHTML = `
            <form container>
                <template>
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label" for="input1">Description</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="input1">
                        </div>
                    </div>
                </template>
            </form>
        `;

        this._containerDom = this.querySelector('[container]');
        this._containerDom.templateDom = this._containerDom.querySelector('template').content.querySelector('div');

        this._list = await this._fetchList();
        this._renderList();
    }

    _containerDom = null;

    _list = [];

    _fetchList = async () => {
        // Fetch the list from an API or other source
        return []; // Placeholder return value
    }

    _renderList = () => {

        const rowDoms = this._list.map((item ) => {

                const rowDom = this._containerDom.templateDom.cloneNode(true);

                const idFor =  'input' + item.id;
                const labelDom = rowDom.querySelector('label');
                labelDom.setAttribute('for', idFor);

                const inputDom = rowDom.querySelector('input');
                inputDom.setAttribute('id', idFor);
                inputDom.value = item.value;

                return rowDom;
        });

        this._containerDom.replaceChildren(...rowDoms);
    }

}

customElements.define('wc-component', jsClass);
```


## 後記

上述的範例，template 結構算是簡單，但實務上，可能會長這樣

```html
<div class="row mb-3 align-items-center">
  <label class="col-sm-2 col-form-label" for="input1">
    使用者名稱
    <span class="ms-1" data-bs-toggle="tooltip" title="請輸入您的全名">
      <i class="bi bi-info-circle"></i>
    </span>
  </label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="input1" placeholder="請輸入姓名">
  </div>
  <label class="col-sm-2 col-form-label" for="input2">
    電子郵件
    <span class="ms-1" data-bs-toggle="tooltip" title="請輸入有效的 Email">
      <i class="bi bi-info-circle"></i>
    </span>
  </label>
  <div class="col-sm-4">
    <input type="email" class="form-control" id="input2" placeholder="example@mail.com">
    <span class="text-danger small ms-1">* 必填</span>
  </div>
</div>
<div class="row mb-3">
  <label class="col-sm-2 col-form-label" for="input3">備註</label>
  <div class="col-sm-10">
    <textarea class="form-control" id="input3" rows="2" placeholder="請輸入備註"></textarea>
    <span class="text-muted small">最多 200 字</span>
  </div>
</div>
```

可以感覺一下，用第二種寫法會是什麼狀況 !