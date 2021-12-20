# 範例一

### 步驟

1. 延續 [mocha](../mocha/mocha.md) 的範例
1. `npm install chai`
1. package.json

    將 mocah 改為對指定路徑及副檔名進行測試

    ```js
    {
    "name": "chai-practice",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
        "test": "mocha ./tests/*.test.js"
    },
    "author": "",
    "license": "ISC",
    "devDependencies": {
        "chai": "^4.3.4",
        "mocha": "^9.1.3"
    }
    }
    ```

1. 新增 `tests/operator.test.js`

    ```js
    let expect = require("chai").expect;

    const operations = require('../src/operator')
    const assert = require('assert')

    it('correctly calculates the sum of 1 and 3', () => {
            
        expect(operations.add(1, 3)).to.equal(4);

    })
    ```

1. 執行 `npm test`


