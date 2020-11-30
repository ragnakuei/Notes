# jQuery Validation

預設進行驗証的時機

1. OnBlur()
2. Form Submit

有二種驗証方式，優先序是  `以 attribute 來定義驗証方式` > `以 js 來定義驗証方式`

一旦定義了 attribute 的方式後，用 js 來定義的動作就不會處理

### 尋找可用參數/方法的方式

1. 在指定的 property / method 下，按下 F12 就會查到 defaults 清單
2. 

---

## 以 attribute 來定義驗証方式

已知 MVC 在套用 Html.ValidationMessageFor() 會自動產生對應的 attribute

純 html 待學習

---

## 以 js 來定義驗証方式

以下範例以 Razor Syntax 為例

需要驗証的 DOM

- 一定要給定 name
- 給定 id 是為了讓錯誤訊息的 label for 可以正確指向

用來顯示錯誤訊息的 Label

- 可不先給定，但會被放到驗証失敗的 dom 後面，可能造成非預期的結構。
- 最好先給定，讓錯誤訊息可以放到想要的位置。
- 最好同時給定 id 跟 for
    - id 的格式是 dom name 加上 `-error`
    - for 只要可以指定至 dom id 就可以

```csharp
<input type="number"
       id="@(nameof(TestViewModel.Id).ToLower())"
       name="@(nameof(TestViewModel.Id).ToLower())" 
       class="form-control" 
       value="@(Model.Id)" />

<label id="@(nameof(TestViewModel.Id).ToLower())-error" 
       class="error" 
       for="@(nameof(TestViewModel.Id).ToLower())" 
       style="display: none;"></label>
```

透過 js 來指定驗証的規則

```jsx
$('#postForm').validate({
    onkeyup : function(element, form) {
        // 如果有需要做去除空白，可以在這邊處理
        console.log(element);
    },
    rules : {
        id : { 
            required : true,
            remote: {
                        url: "/test/validateid",
                        type: "post",
                        data: {
                          id: function() {
                            return $( "#id" ).val();
                          },
                          __RequestVerificationToken : function (){
                            return $( "input[name='__RequestVerificationToken']" ).val();  
                          }
                        },
                         dataFilter: function(data) {
                              // 如果回傳資料是某種資料格式時，可透過這個方式取出，再回傳
                              console.log(data);
                              
                              return data;
                         }
            }
        }
    },
    messages : {
        id : { 
            required : 'id rquired',
            remote: 'id below zero'  
        }
    },
    submitHandler: function(form) {
        // 驗証通過後
        
        form.submit();
    },
    onfocusin : function(element) {
        console.log('onfocusin');
        console.log(element);
    },
    onfocusout : function(element) {
        // default 值會驗証。但這邊如果不驗証的話，那就會跟原本的功能不一致
        $(element).valid();
        
        // 加上這個後，即使原本 focus 有驗証過 & 值未改變的情況下，仍然會 remote 驗驗
        $(element).removeData("previousValue");
        
        console.log('onfocusout');
        console.log(element);
    },
    invalidHandler : function(form, validator) { 
        // 不通過回撥
        return false;
    }
});
```

## 參考資料

[jQuery Validation Plugin表單驗證使用介紹](http://www.cc.ntu.edu.tw/chinese/epaper/0033/20150620_3307.html)