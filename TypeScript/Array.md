# Array

## 初始化宣告方式

```ts
interface ISample
{
    id: number;
    name: string;
}

class Test
{
    constructor() {

    }

    message: string = "hello world";

    // 方式 1
    // dataList: Array<ISample> = Array(
    //     { id: 1, name: 'a' },
    //     { id: 2, name: 'b' },
    // )

    // 方式 2
    dataList: Array<ISample> = [
        { id: 1, name: 'a' },
        { id: 2, name: 'b' },
    ]
}

var c = new Test();
console.log(c.message);
console.table(c.dataList);

```