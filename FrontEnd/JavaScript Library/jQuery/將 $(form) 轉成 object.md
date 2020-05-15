# 將 $(form) 轉成 object

網路上有些做法會用到 jQuery.serializeObject()

但實際上，jQuery 沒有提供對應的 function 

用以下方式可以解決

```javascript
// 擴充 jQuery 來支援轉成 json
$.fn.serializeObject = function () {
  let formArray = $(this).serializeArray();

  let obj = {};
  for (let i = 0; i < formArray.length; i++) {
    obj[formArray[i]["name"]] = formArray[i]["value"];
  }
  return obj;
};
```

使用範例

```javascript
$('#newGroup').serializeObject();
```

之後如果要使用 json，再以 `JSON.stringify(obj)`  就可以了