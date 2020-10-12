# find

-   [querySelector](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector) - 回傳符合 selector 的第一個 element
-   [querySelectorAll](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll) - 回傳所有符合 selector 的 elements

```js
window.ListData = {};
ListData.RegisterListDataColumnEvents = function (tbodyDomId) {
    $(tbodyDomId)
        .find('tr')
        .each(function (index, tr) {
            $(tr).click(function (e) {
                alert(e.currentTarget.outerHTML);
            });
        });
};
```

```js
window.ListData = {};
ListData.RegisterListDataColumnEvents = function (tbodyDomId) {
    document
        .getElementById(tbodyDomId)
        .querySelectorAll('tr')
        .forEach(function (tr) {
            tr.addEventListener('click', function (e) {
                alert(e.currentTarget.outerHTML);
            });
        });
};
```
