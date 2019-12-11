# 從 environment 設定環境變數

預設環境變數檔案：

- /environments/environment.ts
- /environments/environment.prod.ts

於上述二個環境變數檔案中加上對應的環境變數

```typescript
export const environment = {
  production: false,
  apiHost : 'http://localhost:51809/api/'            // 自訂的環境變數
};
```

取得環境變數

```typescript
import { Component, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';    // 2
import { OrderList } from '../models/order-list';

@Injectable()
export class OrderService {

    private apiPath = 'order/list';

    constructor(private httpClient: HttpClient) { }

    GetList() {
        console.log('api host:' + environment.apiHost);         // 1
    }
}
```
