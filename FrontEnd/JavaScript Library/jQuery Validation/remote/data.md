# data

## Samples

### content-type: `application/x-www-form-urlencoded`

property 的給定，請用 function 來回傳，否則只會吃到起始資料

```jsx
remote: {
            url: "/test/validateid",
            type: "post",
            data: {
                   'id': function() { return $( "#id" ).val(); },
                   '__RequestVerificationToken' : function(){ return $( "input[name='__RequestVerificationToken']" ).val(); } 
             },
             dataFilter: function(data) {
                  // 如果回傳資料是某種資料格式時，可透過這個方式取出，再回傳
                  console.log(data);
                  
                  return data;
             }
}
```

### content-type: `application/json`

目前找不到解法

目前的問題在於 data 不吃 function 這個型態的資料

```jsx
remote: {
            url: "/test/validateid",
            type: "post",
            dataType : 'json',
            contentType : 'application/json',
            data: function() {
                var obj = {
                     'id': function() { return $( "#id" ).val(); },
                     '__RequestVerificationToken' : function(){ return $( "input[name='__RequestVerificationToken']" ).val(); } 
               };
                return JSON.stringify(obj);
            },
             dataFilter: function(data) {
                  // 如果回傳資料是某種資料格式時，可透過這個方式取出，再回傳
                  console.log(data);
                  
                  return data;
             }
}
```