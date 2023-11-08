# checkbox

```html
<div>
    <wc-checkbox id="checkbox"></wc-checkbox>
</div>

<script>
    const checkbox = document.getElementById('checkbox');
    checkbox.checked = true;
    checkbox.addEventListener('onCheckedChange', (e) => {
        console.log(e.detail.checked);
    });
</script>
<script>
    customElements.define(
        'wc-checkbox',
        class extends HTMLElement {
            constructor() {
                super();
                this.innerHTML = `
<style nonce="123abc">
    .hide {
        display: none !important;
    }
    
    .checked {
        display: inline-block;
        font-size: 20px;
        user-select: none;
    }
    
    .unchecked {
        display: inline-block;
    }
    
    .checkbox {
        cursor: pointer;
        width: 20px;
        height: 20px;
        border: 1px solid #ccc;
        text-align: center;
    }
</style>
<span class="checkbox checked hide">V</span>
<span class="checkbox unchecked hide"></span>
                    `;
            }

            connectedCallback() {
                this._checkedDom = this.querySelector('.checked');
                this._checkedDom.addEventListener('click', () => {
                    this._setUnChecked();
                });

                this._unCheckedDom = this.querySelector('.unchecked');
                this._unCheckedDom.addEventListener('click', () => {
                    this._setChecked();
                });

                this.Checked = this._checked;
            }

            _checked = false;
            _checkedDom = null;
            _unCheckedDom = null;

            set Checked(value) {
                if (value) {
                    this._setChecked();
                } else {
                    this._setUnChecked();
                }
            }
            get Checked() {
                return this._checked;
            }

            _setChecked = () => {
                this._checked = true;
                this._checkedDom.classList.remove('hide');
                this._unCheckedDom.classList.add('hide');
                this._dispatchEvent();
            };

            _setUnChecked = () => {
                this._checked = false;
                this._checkedDom.classList.add('hide');
                this._unCheckedDom.classList.remove('hide');
                this._dispatchEvent();
            };

            _dispatchEvent() {
                this.dispatchEvent(
                    new CustomEvent('onCheckedChange', {
                        detail: {
                            checked: this._checked,
                        },
                    }),
                );
            }
        },
    );
</script>
```
