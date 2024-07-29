# tarekraafat-autocomplete

- [官網](https://tarekraafat.github.io/autoComplete.js)
- [Github](https://github.com/TarekRaafat/autoComplete.js)


```js
const keywordAutoComplete = new autoComplete({
    selector: `#${this.id} #keyword`,
    // placeHolder: "Input Keywords",
    debounce: 500,
    data: {
        src: async (query) => {
            try {
                const url = '/api/QryEmpno/GetKeywords';
                const keywords = await ajaxPostJson(url, query);
                return keywords;
            } catch (error) {
                return error;
            }
        },
    },
    resultItem: {
        highlight: true,
    },
});
```

### properties

```js
console.log(keywordAutoComplete.isOpen);
```