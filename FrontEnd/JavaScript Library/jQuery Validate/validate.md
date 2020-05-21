# validate()

### 用來設定驗証規則

```jsx
let validator = $('#postForm').validate({
									    onkeyup : function(element, form) {
									        console.log(element);
									    },
			                rules : {
			                    id : { required : true },
			                    name : { required : true },
			                    age : { required : true },
			                },
			                messages : {
			                    id : { required : 'id rquired' },
			                    name : { required : 'name rquired' },
			                    age : { required : 'age rquired' },
			                },
									    submitHandler: function(form) {
									        console.log( 'form.valid() = ' + $(form).valid());
									        form.submit();
									    }
			            });
```

### onkeyup

如果有需要做去除空白，可以在這邊處理

### rules

[rules](validate%202f807f25faf445cc8afe35adf63b2a67/rules%2078acc49175984971bc0e080667090885.csv)

### messages

用來指定對應 rules 的錯誤訊息

### submitHandler

只要驗証通過，就會呼叫這邊的程式

TODO:  remote 如何只做一次性驗証 ?