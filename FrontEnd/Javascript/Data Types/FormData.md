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
