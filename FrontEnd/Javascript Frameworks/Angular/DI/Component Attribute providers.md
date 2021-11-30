# Component Attribute providers

[Injectable](Injectable.md) 設定了可以被 DI 取出的 Type 及 Scope !

providers 則比較像是 DI 怎麼從上述的 Scope 中取出 Instance

### 情境一：Transient 效果

```ts
@Component({
    selector: 'app-order-list',
  templateUrl: './order-list.component.html',
  styleUrls: [ './order-list.component.css' ],
  providers : [
      // 指定要被 DI 的 Type
      OrderStorageService,
  ]
})
export class OrderListComponent implements OnInit { }
```

### 情境二：Singleton 效果

```ts
@Component({
  selector: 'app-order-list',
  templateUrl: './order-list.component.html',
  styleUrls: [ './order-list.component.css' ],

  providers : [
      // 不需要指定 providers 
      // OrderStorageService,
  ]
})
export class OrderListComponent implements OnInit { }
```