# table tr 內容放至另一個 Component 的方式

Q：照原本的情況，在 table 所在的 component 的 template

```html
<app-order-item 
    *ngFor="let item of list; index as i" 
    [orderList]="item">
    <tr (click)="onSelect(orderList.OrderID)">
    </tr>
</app-order-item>
```

而 app-order-item 的 template 是

```html
<tr>
    <td>{{ orderList.OrderID }}</td>
    <td>{{ orderList.CustomerID }}</td>
    <td>{{ orderList.EmployeeID }}</td>
    <td>{{ orderList.OrderDate | date: 'yyyy-MM-dd' }}</td>
    <td>{{ orderList.RequiredDate | date: 'yyyy-MM-dd' }}</td>
    <td>{{ orderList.ShippedDate | date: 'yyyy-MM-dd' }}</td>
    <td>{{ orderList.ShipVia }}</td>
    <td>{{ orderList.Freight }}</td>
    <td>{{ orderList.ShipName }}</td>
    <td>{{ orderList.ShipAddress }}</td>
    <td>{{ orderList.ShipCity }}</td>
    <td>{{ orderList.ShipRegion }}</td>
    <td>{{ orderList.ShipPostalCode }}</td>
    <td>{{ orderList.ShipCountry }}</td>
    <td>{{ orderList.DetailCount }}</td>
</tr>
```

長出來的 html 就會是

```html
<table>
    <app-order-item _nghost-uts-c1="" ng-reflect-order-list="[object Object]">
        <tr _ngcontent-uts-c1="">
            <td _ngcontent-uts-c1="">10248</td>
            <td _ngcontent-uts-c1="">VINET</td>
            <td _ngcontent-uts-c1="">5</td>
            <td _ngcontent-uts-c1="">1996-07-04</td>
            <td _ngcontent-uts-c1="">1996-08-01</td>
            <td _ngcontent-uts-c1="">1996-07-16</td>
            <td _ngcontent-uts-c1="">3</td>
            <td _ngcontent-uts-c1="">32.38</td>
            <td _ngcontent-uts-c1="">Vins et alcools Chevalier</td>
            <td _ngcontent-uts-c1="">59 rue de l'Abbaye</td>
            <td _ngcontent-uts-c1="">Reims</td>
            <td _ngcontent-uts-c1=""></td>
            <td _ngcontent-uts-c1="">51100</td>
            <td _ngcontent-uts-c1="">France</td>
            <td _ngcontent-uts-c1="">3</td>
        </tr>
    </app-order-item>
</table>
```

---

A： 解決方式

1. 把外層 component 的 template 改成

    app-order-item 變成以 attribute 的方式給定，而不是原本的 html tag

    ```html
    <tr *ngFor="let item of list; index as i" (click)="onSelect(item.OrderID)" app-order-item [orderList]="item">
    </tr>
    ```

1. 把 app-order-item component 的 selector 從

    > selector: 'app-order-item',

    改成

    > selector: '[app-order-item]',

1. 把 app-order-item template 的 tr 去掉

    ```html
    <td>{{ orderList.OrderID }}</td>
    <td>{{ orderList.CustomerID }}</td>
    <td>{{ orderList.EmployeeID }}</td>
    <td>{{ orderList.OrderDate | date: 'yyyy-MM-dd' }}</td>
    <td>{{ orderList.RequiredDate | date: 'yyyy-MM-dd' }}</td>
    <td>{{ orderList.ShippedDate | date: 'yyyy-MM-dd' }}</td>
    <td>{{ orderList.ShipVia }}</td>
    <td>{{ orderList.Freight }}</td>
    <td>{{ orderList.ShipName }}</td>
    <td>{{ orderList.ShipAddress }}</td>
    <td>{{ orderList.ShipCity }}</td>
    <td>{{ orderList.ShipRegion }}</td>
    <td>{{ orderList.ShipPostalCode }}</td>
    <td>{{ orderList.ShipCountry }}</td>
    <td>{{ orderList.DetailCount }}</td>
    ```

就可以了
