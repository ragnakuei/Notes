# Component

## app.module 加 Component 的方式

```typescript
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { RouterModule, Routes } from '@angular/router';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

// Service
import { OrderService } from "./order/order.service";

// Component
import { OrderListComponent } from './order/order.list.component';  // 2

const appRoutes: Routes = [
  { path: '', component: AppComponent },
  { path: 'order/list', component: OrderListComponent }             // 3 - 指其 Route
];

@NgModule({
  declarations: [
    AppComponent,
    OrderListComponent                                              // 1
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    RouterModule.forRoot(appRoutes)
  ],
  providers: [OrderService],
  bootstrap: [AppComponent]
})
export class AppModule {

}
```

---

## 指定 html 的方式

使用 Component Property : templateUrl

以相對路徑給定 !

```typescript
import { Component } from '@angular/core';
import { OrderService } from './order.service';

@Component({
  selector: 'order-list',
  templateUrl: './list.component.html',
  styles: []
})
export class OrderListComponent {

    list : string[];

    constructor(orderService:OrderService) {
        this.list = orderService.GetList();
    }
}
```

---

## 內嵌 html 的方式

使用 Component Property : template

- html 內只有一行 - 以 單引號 包住 html 語法
- html 內有多行 - 以 反引號 包住 html 語法

```typescript
import { Component } from '@angular/core';
import { OrderService } from './order.service';

@Component({
  selector: 'order-list',
  template: 'OrderListComponent',
  styles: []
})
export class OrderListComponent {

    list : string[];

    constructor(orderService:OrderService) {
        this.list = orderService.GetList();
    }
}
```

> 注意： templateUrl 的優先序 大於 template

