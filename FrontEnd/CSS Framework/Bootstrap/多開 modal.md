# 多開 modal

### 原理釐清

bootstrap v5 modal 明確說明：不要多開 modal !

-   https://getbootstrap.com/docs/5.0/components/modal/#toggle-between-modals

因為多開時，會在 body CSS 加上 `modal-open`，這個 class 會讓 scrollbar 可以在當前的 modal 內滾動
但是 boostrap modal 無法判斷是否有多開 modal，所以只要關掉一個 modal 就會把 `modal-open` 移除

這是 v3.3.5 的提到的原理

-   https://stackoverflow.com/questions/32835946/multiple-modal-dialog-scroll-bar-bootstrap-v-3-3-5-not-working-well

目前測試可以解 v4 多開造成 scrollbar 的問題

### v4 解法

建立一個 Store 來管理 modal，透過這個 Store 來控制 modal 的開關
當關閉時，判斷是否還有其他 modal，如果有，就透過事件來加回 `modal-open` class

```js
class BootstrapModalStore {
    // 開啟的 modals
    _modals = [];

    Show = (element) => {
        const selector = '.modal';
        const dom = element.querySelector(selector);

        const modalInstance = this._initialBootstrapModal(dom);
        this._modals.push({
            dom,
            selector,
            instance: modalInstance,
        });

        if (this._modals.some((m) => m.instance === modalInstance) === false) {
            return;
        }

        modalInstance.show();

        return modalInstance;
    };

    Hide = (modalInstance) => {
        // 2 是除了自已外，還有其他 modal
        const keepBodyCssClass = this._modals.length >= 2;

        let targetModalObj = this._modals[this._modals.length - 1];

        if (targetModalObj.instance !== modalInstance) {
            alert('Bootstrap 操作產生非預期錯誤 !');

            targetModalObj = this._modals.find(
                (m) => m.instance === modalInstance,
            );
        }

        if (keepBodyCssClass) {
            this._keepBodyCssClass(targetModalObj.selector);
        }

        // 移除 targetModalObj
        this._modals = this._modals.filter((m) => m.instance !== modalInstance);

        targetModalObj.instance.hide();
    };

    _initialBootstrapModal = (dom, options) => {
        return new bootstrap.Modal(dom, {
            ...options,
            // 因應規範要求：點到空白處不可關閉
            backdrop: 'static',
            keyboard: false,
        });
    };

    _keepBodyCssClass = (modalSelector) => {
        $(modalSelector).on('hidden.bs.modal', () => {
            // console.log('trigger hidden.bs.modal');
            document.body.classList.add('modal-open');

            $(modalSelector).off('hidden.bs.modal');
        });
    };
}
```
