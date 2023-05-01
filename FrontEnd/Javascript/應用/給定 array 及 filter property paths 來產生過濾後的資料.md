# 給定 array 及 filter property paths 來產生過濾後的資料

```js
const data = [
    { A: 'A01', B: { id: 'B01', C: { id: 'C01' } }, },
    { A: 'A01', B: { id: 'B01', C: { id: 'C01' } }, },
    { A: 'A01', B: { id: 'B01', C: { id: 'C01' } }, },
    { A: 'A01', B: { id: 'B01', C: { id: 'C01' } }, },
    { A: 'A01', B: { id: 'B01', C: { id: 'C01' } }, },
    { A: 'A02', B: { id: 'B01', C: { id: 'C01' } }, },
    { A: 'A02', B: { id: 'B01', C: { id: 'C01' } }, },
    { A: 'A02', B: { id: 'B01', C: { id: 'C02' } }, },
    { A: 'A02', B: { id: 'B02', C: { id: 'C02' } }, },
    { A: 'A02', B: { id: 'B02', C: { id: 'C02' } }, },
    { A: 'A03', B: { id: 'B02', C: { id: 'C02' } }, },
    { A: 'A03', B: { id: 'B02', C: { id: 'C02' } }, },
    { A: 'A03', B: { id: 'B03', C: { id: 'C02' } }, },
    { A: 'A03', B: { id: 'B03', C: { id: 'C02' } }, },
    { A: 'A03', B: { id: 'B03', C: { id: 'C02' } }, },
    { A: 'A03', B: { id: 'B03', C: { id: 'C02' } }, },
    { A: 'A03', B: { id: 'B03', C: { id: 'C03' } }, },
    { A: 'A03', B: { id: 'B03', C: { id: 'C03' } }, },
    { A: 'A03', B: { id: 'B03', C: { id: 'C03' } }, },
    { A: 'A03', B: { id: 'B03', C: { id: 'C03' } }, },
];

const filters = [
    { name: 'A', value: 'A02', path: 'A' },
    { name: 'B', value: 'B01', path: 'B.id' },
    { name: 'C' ,value: 'C02', path: 'B.C.id' }
]

const filterData = (data, filters) => {
    return data.filter((item) => {
        console.log('------------------- start');
        console.log('item', item);
        const everyResult = filters.every((filter) => {

            // 使用 reduce 將 filterPropertyPath 拆解成 property array
            const filterPaths = filter.path.split('.');
          
            // 使用 reduce 操作取得符合 filterPropertyPath 的值
            const propertyValue = filterPaths.reduce((obj, prop) => {
              if (obj && obj.hasOwnProperty(prop)) {
                return obj[prop];
              }
              return undefined;
            }, item);

            console.log('---');
            console.log('filter.path', filter.path);
            console.log('propertyValue === filter.value', `=> ${propertyValue} === ${filter.value} => ${propertyValue === filter.value}`);

            return propertyValue === filter.value;
        });

        console.log('everyResult', everyResult);
        console.log('------------------- end');

        return everyResult;
    });
};

console.log(filterData(data, filters));
```