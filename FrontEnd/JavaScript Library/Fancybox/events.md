# [events](https://fancyapps.com/fancybox/3/docs/#events)

以 `$("[data-fancybox]").fancybox()` 來指定整個頁面上的 fancybox 非預設的內容

## afterShow

```javascript
$("[data-fancybox]").fancybox({
        afterShow: function( instance, slide ) {
            console.log('afterShow');
        }
});
```