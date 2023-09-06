# [FormData](https://developer.mozilla.org/zh-TW/docs/Web/API/FormData)

### 範例

```js
const formData = new FormData();
formData.append('Title', 'A');
formData.append('Description', 'B');

for (var pair of formData.entries()) {
    console.log(pair[0]+ ', ' + pair[1]);
}
```

### 取得 FormData 容量

```js
function getFormDataSize(formData) {
    let size = 0;
    for (const [key, value] of formData.entries()) {

        let itemSize = 0;
        if(typeof value === 'string') {
            // 如果該欄位是字串，則取得字串長度
            itemSize = value.length;
        } else if (typeof value === 'number') {
            // 如果該欄位是數字，則取得字串容量
            itemSize = value.toString().length;
        } else if (Object.prototype.toString.call(value) === '[object File]') {
            // 如果該欄位是檔案，則取得檔案容量
            itemSize = value.size;
        } else {
            // 其餘的都當作字串處理
            itemSize = value.toString().length;
        }

        size += itemSize;
    }
    return size;
}

var formData = new FormData();
formData.append('Title', 'A');
formData.append('Description', 'B');
formData.append('File', document.getElementById('file').files[0]);

const formDataSize = getFormDataSize(formData);

```