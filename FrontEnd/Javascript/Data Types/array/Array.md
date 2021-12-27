# Array

---

## map()

- 對應至 C# Linq 的 Select()

## filter

- 對應至 C# Linq 的 Where()


## reduce

- 對應至C# Linq 的 Aggregate()

### 範例

```js
let array1 = [1, 2, 3, 4];

const reducer = (aggregateValue, iteratorValue) => {
    console.log(aggregateValue);
    console.log(iteratorValue);
    return aggregateValue + iteratorValue;
};

array1.reduce(reducer);
```

## unshift

- push element at index 0

## shift

- pop index 0 element

