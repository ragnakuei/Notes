# toast

### option

- autohide: true - 是否於 5 秒後自動隱藏

### 有 toast-container

toast-container

-   定義其位置定義，如下 position-absolute，代表 position: absolute
-   定義其位置，如下 top-50 start-50 translate-middle，代表置中
-   在 toast-containner 內的 toast 可以自動 stack !

```html
<div class="toast-container position-absolute top-50 start-50 translate-middle">
    <div
        ref="loadingSpinnerToastDom"
        class="toast hide text-primary"
        role="alert"
        aria-live="assertive"
        aria-atomic="true"
    >
        <div
            class="toast-body d-flex justify-content-center align-items-center gap-3 fs-4"
        >
            <div class="spinner-border" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            Loading ...
        </div>
    </div>

    <div
        ref="notifyInformationToastDom"
        class="toast hide"
        v-bind:class="toastClass"
        role="alert"
        aria-live="assertive"
        aria-atomic="true"
    >
        <div
            class="toast-body d-flex justify-content-center align-items-center gap-3 fs-5"
        >
            <i class="bi bi-check-lg"></i>
            {{ obj.message }}
        </div>
    </div>
</div>
```

上述語法有搭配 vue

-   其中 toastClass 為 computed，用來定義 icon 的顏色

```js
setup() {

    const notifyInformationToastDom = ref(null);
    const notifyInformationToastInstance = ref(null);
    const obj = ref({});
    const toastClass = computed(() => {
        return 'text-' + obj.value.iconType ?? 'primary';
    });

    // 顯示
    // obj
    // {
    //      iconType (primary, secondary, success, danger, warning, info, light, dark)
    //      message  (string) 顯示的訊息
    //      delay    (number) 多少 ms 後自動隱藏
    // }
    function show(inputObj) {
        obj.value = inputObj;

        // 這邊使用 setTimeout 的原因是，避免變動 class 而導致 toast 無法顯示
        // 也可以用 await nextTick() 來達到相同效果
        setTimeout(() => {
            notifyInformationToastInstance.value.show();
        }, 0);

        if ( obj.value.delay > 0 ) {
            setTimeout(() => {
                hide();
            }, obj.value.delay);
        }
    }

    // 不顯示
    function hide() {
        notifyInformationToastInstance.value.hide();
    }

    onMounted(() => {
        notifyInformationToastInstance.value = new bootstrap.Toast(notifyInformationToastDom.value, {
            autohide: false,
            animation: true,
        })
    })

    return {
        notifyInformationToastDom,
        obj,
        toastClass,
        show,
        hide,
    };
}
```
