# 擴充 jQuery 的方式

```js
jQuery.fn.enable = function () {
    $(this).attr('disabled', false);
};
jQuery.fn.disable = function () {
    $(this).attr('disabled', true);
};
```

就可以在給定 selector 時，直接使用

```js
$('#btn').enable();

$('#btn').disable();
```
