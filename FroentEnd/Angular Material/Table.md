# [Table](https://material.angular.io/components/table/overview)

> import { MatTableModule } from '@angular/material/table';

---

## Sample01

```typescript
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { OrderList } from 'src/app/models/OrderList';
import { OrderService } from '../order.service';
import { MatTableDataSource } from '@angular/material/table';

@Component({
    templateUrl: './order.list.component.html',
    styles: []
})
export class OrderListComponent implements OnInit {
    orderListDataSource = new MatTableDataSource<OrderList>();
    displayedColumns: string[] = ['OrderID'];

    list: OrderList[] = [];

    constructor(private orderService: OrderService,
        private router: Router,
        private route: ActivatedRoute) {
    }

    ngOnInit(): void {

        this.orderService.getList()
            .subscribe(
                resp => {
                    this.orderListDataSource.data = resp;
                },
                err => console.log('Error', err));
    }

    onSelect(orderId: number) {
        console.log(orderId);
        this.router.navigate(['/order/detail/' + orderId]);
    }
}
```

```html
<h2>OrderList</h2>

<table mat-table [dataSource]="orderListDataSource">
  <!-- 這是 Header Row 的定義 -->
  <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>

  <!-- 這是 Data 各 Row 的 Template 定義，如果要加 (click) 要加在這邊 -->
  <tr mat-row *matRowDef="let row; columns: displayedColumns"></tr>
  
  <!-- 以下是各 Column Cell 的定義 -->
  <ng-container matColumnDef="OrderID">
    <th mat-header-cell *matHeaderCellDef>OrderId</th>
    <td mat-cell *matCellDef="let order">{{ order.OrderID }}</td>
  </ng-container>

  <ng-container matColumnDef="CustomerID">
    <th mat-header-cell *matHeaderCellDef>CustomerID</th>
    <td mat-cell *matCellDef="let order">{{ order.CustomerID }}</td>
  </ng-container>

  <ng-container matColumnDef="EmployeeID">
    <th mat-header-cell *matHeaderCellDef>EmployeeID</th>
    <td mat-cell *matCellDef="let order">{{ order.EmployeeID }}</td>
  </ng-container>

  <ng-container matColumnDef="OrderDate">
    <th mat-header-cell *matHeaderCellDef>OrderDate</th>
    <td mat-cell *matCellDef="let order">{{ order.OrderDate | date: 'yyyy-MM-dd' }}</td>
  </ng-container>

  <ng-container matColumnDef="RequiredDate">
    <th mat-header-cell *matHeaderCellDef>RequiredDate</th>
    <td mat-cell *matCellDef="let order">{{ order.RequiredDate | date: 'yyyy-MM-dd' }}</td>
  </ng-container>

  <ng-container matColumnDef="ShippedDate">
    <th mat-header-cell *matHeaderCellDef>ShippedDate</th>
    <td mat-cell *matCellDef="let order">{{ order.ShippedDate | date: 'yyyy-MM-dd' }}</td>
  </ng-container>

  <ng-container matColumnDef="ShipVia">
    <th mat-header-cell *matHeaderCellDef>ShipVia</th>
    <td mat-cell *matCellDef="let order">{{ order.ShipVia }}</td>
  </ng-container>

  <ng-container matColumnDef="Freight">
    <th mat-header-cell *matHeaderCellDef>Freight</th>
    <td mat-cell *matCellDef="let order">{{ order.Freight }}</td>
  </ng-container>

  <ng-container matColumnDef="ShipName">
    <th mat-header-cell *matHeaderCellDef>ShipName</th>
    <td mat-cell *matCellDef="let order">{{ order.ShipName }}</td>
  </ng-container>

  <ng-container matColumnDef="ShipAddress">
    <th mat-header-cell *matHeaderCellDef>ShipAddress</th>
    <td mat-cell *matCellDef="let order">{{ order.ShipAddress }}</td>
  </ng-container>

  <ng-container matColumnDef="ShipCity">
    <th mat-header-cell *matHeaderCellDef>ShipCity</th>
    <td mat-cell *matCellDef="let order">{{ order.ShipCity }}</td>
  </ng-container>

  <ng-container matColumnDef="ShipRegion">
    <th mat-header-cell *matHeaderCellDef>ShipRegion</th>
    <td mat-cell *matCellDef="let order">{{ order.ShipRegion }}</td>
  </ng-container>

  <ng-container matColumnDef="ShipPostalCode">
    <th mat-header-cell *matHeaderCellDef>ShipPostalCode</th>
    <td mat-cell *matCellDef="let order">{{ order.ShipPostalCode }}</td>
  </ng-container>

  <ng-container matColumnDef="ShipCountry">
    <th mat-header-cell *matHeaderCellDef>ShipCountry</th>
    <td mat-cell *matCellDef="let order">{{ order.ShipCountry }}</td>
  </ng-container>

  <ng-container matColumnDef="DetailCount">
    <th mat-header-cell *matHeaderCellDef>DetailCount</th>
    <td mat-cell *matCellDef="let order">{{ order.DetailCount }}</td>
  </ng-container>
</table>
```
