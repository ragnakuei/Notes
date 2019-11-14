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
