# globalProperties

### 取代 pipe 的做法

```js
const app = createApp({ ... });

app.config.globalProperties.$pipe = {
    // value 是 DateTime 字串
    formatDate(value, format = 'yyyyMMdd') {
        const date = new Date(value);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');

        switch (format) {
            case 'yyyyMMdd':
                return `${year}${month}${day}`;
            case 'yyyy-MM-dd':
                return `${year}-${month}-${day}`;
        }

        return `${year}${month}${day}`;
    },
};


// 使用

tempalte: `
    <div>
        {{ $pipe.formatDate('2021-01-01', 'yyyyMMdd') }}
    </div>
`
```
