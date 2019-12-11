# Service

app.module 加 Service 的方式，就可以 DI 給需要的 Component

以下方註解標示要注意的順序

> // n

```typescript
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { RouterModule, Routes } from '@angular/router';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

// Service
import { OrderService } from "./order/order.service";              // 2

// Component
import { OrderListComponent } from './order/order.list.component';  

const appRoutes: Routes = [
  { path: '', component: AppComponent },
  { path: 'order/list', component: OrderListComponent }
];

@NgModule({
  declarations: [
    AppComponent,
    OrderListComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    RouterModule.forRoot(appRoutes)
  ],
  providers: [OrderService],                                       // 1
  bootstrap: [AppComponent]
})
export class AppModule {

}
```
