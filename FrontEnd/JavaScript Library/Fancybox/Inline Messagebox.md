# Inline Messagebox

---

資料來源

[http://fancyapps.com/fancybox/3/docs/#usage](http://fancyapps.com/fancybox/3/docs/#usage)

有 demo 可以看

### 直接指定 html 來顯示 Lightbox 內容

```javascript
function OpenSuccessMessagebox(message) {
    var inlineHtml = '<div style="max-width:600px;" id="trueModal"> <h2></h2> <p>'+message+'</p> <p><button data-fancybox-close class="btn">Close</button></p> </div>';
    $.fancybox.open(inlineHtml);
}
```