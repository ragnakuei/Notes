# [export](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export)

## 範例一 - 匯出多個 module

```ts
class CounterService {
    public counter: number;

    constructor() {
        this.counter = 0;
    }
}

export const stateCounterService = new CounterService();
export const statelessCounterService = CounterService;
```

使用方式

- 下面三種其中一種都可以

```ts
import { stateCounterService } from '@/services/CounterService';
import { statelessCounterService } from '@/services/CounterService';
import { stateCounterService, statelessCounterService } from '@/services/CounterService';
```