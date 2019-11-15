# Reactive Forms

```typescript
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { ReactiveFormsModule } from '@angular/forms';      // 2

// Service
import { OrderService } from "./order/order.service";

// Component
import { HomeComponent } from './home/home.component';
import { OrderComponent } from './order/order.component';
import { OrderListComponent } from './order/order-list/order.list.component';
import { OrderDetailComponent } from './order/order-detail/order-detail.component';
import { OrderItemComponent } from './order/order-list/order-item/order-item.component';
import { OrderEditComponent } from './order/order-edit/order-edit.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    OrderComponent,
    OrderListComponent,
    OrderDetailComponent,
    OrderItemComponent,
    OrderEditComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule                                      // 1
  ],
  providers: [OrderService],
  bootstrap: [AppComponent]
})
export class AppModule {

}

```

---

給定 FormGroup 值的方式：透過 FormGroup.setValue()

```typescript
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormControl } from '@angular/forms';
import { OrderService } from '../order.service';
import { ActivatedRoute, Router, Params } from '@angular/router';
import { Order } from 'src/app/models/Order';
import { OrderForm } from 'src/app/models/OrderForm';

@Component({
    selector: 'app-order-edit',
    templateUrl: './order-edit.component.html',
    styleUrls: ['./order-edit.component.css']
})
export class OrderEditComponent implements OnInit {

    id: number;
    orderForm: FormGroup;

    constructor(private orderService: OrderService,
        private formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private router: Router) {
    }

    ngOnInit() {
        this.orderForm = new FormGroup({
            OrderID: new FormControl(''),
            CustomerID: new FormControl(''),
            EmployeeID: new FormControl(''),
            OrderDate: new FormControl(''),
            RequiredDate: new FormControl(''),
            ShippedDate: new FormControl(''),
            ShipVia: new FormControl(''),
            Freight: new FormControl(''),
            ShipName: new FormControl(''),
            ShipAddress: new FormControl(''),
            ShipCity: new FormControl(''),
            ShipRegion: new FormControl(''),
            ShipPostalCode: new FormControl(''),
            ShipCountry: new FormControl(''),
        });

        this.route.params
            .subscribe(
                (params: Params) => {
                    this.id = params['id'];
                    this.orderService.getOrder(this.id)
                        .subscribe(
                            resp => {

                                this.orderForm.setValue({
                                    OrderID: resp.body.OrderID,
                                    CustomerID: resp.body.CustomerID,
                                    EmployeeID: resp.body.EmployeeID,
                                    OrderDate: resp.body.OrderDate,
                                    RequiredDate: resp.body.RequiredDate,
                                    ShippedDate: resp.body.ShippedDate,
                                    ShipVia: resp.body.ShipVia,
                                    Freight: resp.body.Freight,
                                    ShipName: resp.body.ShipName,
                                    ShipAddress: resp.body.ShipAddress,
                                    ShipCity: resp.body.ShipCity,
                                    ShipRegion: resp.body.ShipRegion,
                                    ShipPostalCode: resp.body.ShipPostalCode,
                                    ShipCountry: resp.body.ShipCountry,
                                });
                            });
                }
            );
    }

    onSubmit(submitData: OrderForm) {
        console.log(submitData);
    }
}
```

template

```html
<h2>OrderEdit</h2>

<form [formGroup]="orderForm" (ngSubmit)="onSubmit(orderForm.value)">

    <div> <label for="OrderID"> OrderID </label> <input id="OrderID" type="text" formControlName="OrderID" readonly> </div>
    <div> <label for="CustomerID"> CustomerID </label> <input id="CustomerID" type="text" formControlName="CustomerID"> </div>
    <div> <label for="EmployeeID"> EmployeeID </label> <input id="EmployeeID" type="text" formControlName="EmployeeID"> </div>
    <div> <label for="OrderDate"> OrderDate </label> <input id="OrderDate" type="text" formControlName="OrderDate"> </div>
    <div> <label for="RequiredDate"> RequiredDate </label> <input id="RequiredDate" type="text" formControlName="RequiredDate"> </div>
    <div> <label for="ShippedDate"> ShippedDate </label> <input id="ShippedDate" type="text" formControlName="ShippedDate"> </div>
    <div> <label for="ShipVia"> ShipVia </label> <input id="ShipVia" type="text" formControlName="ShipVia"> </div>
    <div> <label for="Freight"> Freight </label> <input id="Freight" type="text" formControlName="Freight"> </div>
    <div> <label for="ShipName"> ShipName </label> <input id="ShipName" type="text" formControlName="ShipName"> </div>
    <div> <label for="ShipAddress"> ShipAddress </label> <input id="ShipAddress" type="text" formControlName="ShipAddress"> </div>
    <div> <label for="ShipCity"> ShipCity </label> <input id="ShipCity" type="text" formControlName="ShipCity"> </div>
    <div> <label for="ShipRegion"> ShipRegion </label> <input id="ShipRegion" type="text" formControlName="ShipRegion"> </div>
    <div> <label for="ShipPostalCode"> ShipPostalCode </label> <input id="ShipPostalCode" type="text" formControlName="ShipPostalCode"> </div>
    <div> <label for="ShipCountry"> ShipCountry </label> <input id="ShipCountry" type="text" formControlName="ShipCountry"> </div>

    <button class="button" type="submit">Send</button>

</form>
```
