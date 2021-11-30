# Component Attribute providers

[Injectable](Injectable.md) 設定了可以被 DI 取出的 Type 及 Scope !

providers 則比較像是 DI 怎麼從上述的 Scope 中取出 Instance

### 情境一：Transient 效果

- 只要 Component 被 Destroy 後，被 DI 的 instance 也隨之被 Destroy

```ts
@Component({
    selector: 'app-order-list',
  templateUrl: './order-list.component.html',
  styleUrls: [ './order-list.component.css' ],
  providers : [
      // 指定要被 DI 的 Type 為 Transient 效果
      OrderStorageService,
  ]
})
export class OrderListComponent implements OnInit { }
```

### 情境二：Singleton 效果

- 只要 Component 被 Destroy 後，被 DI 的 instance 不會被 Destroy
- 此時就可以套用 Injectable Scope 設定的效果

    - 單一 Module **( providedIn 為 'any' 或指定的 modules )** 
    - Application Root **( providedIn 為 'root' )** 
  
  有不同的使用情境了 !

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