# [HttpClient](https://angular.io/guide/http)

Angular 5 之後才有的 Library

app.module.ts 要新增 imports HttpClientModule

```typescript

import { HttpClientModule } from '@angular/common/http';   // 2


@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    OrderListComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule                                       // 1
  ],
  providers: [OrderService],
  bootstrap: [AppComponent]
})
export class AppModule {

}
```

---

debug 用語法

```typescript
return this.httpClient.put<Order>(environment.apiHost + "order/" + order.OrderID , order , this.httpOptions)
.subscribe(
  val => {
    console.log("PUT call successful value returned in body",val);
  },
  response => {
    console.log("PUT call in error", response);
  },
  () => {
    console.log("The PUT observable is now completed.");
  }
);
```

---

get with query string

```typescript
getList(pageIndex: number, pageSize: number): Observable<OrderList[]> {
  return this.httpClient
    .get<OrderList[]>(environment.apiHost + "order/list", {
      params: {
        pageIndex: pageIndex.toString(),
        pageSize: pageSize.toString()
      },
      observe: "response"
    })
    .pipe(
      map(resp => resp.body),
      tap(_ => this.log("get order list"))
    );
}
```

---

TODO：加上 retry 機制
