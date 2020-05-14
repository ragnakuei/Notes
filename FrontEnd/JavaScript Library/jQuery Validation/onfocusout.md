# onfocusout()

---

```jsx
onfocusout : function(element) {
    // default 值會驗証。但這邊如果不驗証的話，那就會跟原本的功能不一致
    $(element).valid();
    
    // 加上這個後，即使原本 focus 有驗証過 & 值未改變的情況下，仍然會 remote 驗驗
    $(element).removeData("previousValue");
    
    console.log('onfocusout');
    console.log(element);
},
```