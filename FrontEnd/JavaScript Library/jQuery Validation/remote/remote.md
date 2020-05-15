# remote

---

透過 ajax 來驗証


| 欄位名     | 說明                             |
| ---------- | -------------------------------- |
| url        | 後端 API URL                     |
| type       | 指定 http method 為 get / post   |
| data       | 用來組成 request body            |
| dataFilter | 處理從後端驗証完的 response 資料 |


預設讀取 remote api 的 response 值 true / false

如果回傳資料是某種 json 資料格式時，可透過 dataFilter 處理

__RequestVerificationToken  是為了 MVC 的 Post ValidateAntiForgeryToken 驗証

```javascript
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
                              console.log(data);
                              
                              return data;
                         }
                      }  
        },
    },
    messages : {
        id : { 
            required : 'id rquired',
            remote: 'id below zero'  
        },
    },
    submitHandler: function(form) {
        // 驗証通過後
        
        form.submit();
    }
});
```

## Bug

這邊提到， remote 驗証結果是會被 cache 下來的

[Jquery validation remote 驗證的快取問題解決方法](https://codertw.com/%E5%89%8D%E7%AB%AF%E9%96%8B%E7%99%BC/285885/)

解決方式

```jsx
$(“#schoolId”).change(function(){
		$(“#gradeId”).removeData(“previousValue”);
});
```