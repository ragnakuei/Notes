# setDefaults

## 不在 keyup 就進行驗証

> 會變成 onblur 才會進行驗証

```javascript
$.validator.setDefaults({
    onkeyup: false
})
```