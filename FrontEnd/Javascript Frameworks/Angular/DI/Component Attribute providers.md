# Component Attribute providers

[Injectable](Injectable.md) 設定了可以被 DI 取出的 Type 及 Scope !

providers 則比較像是 DI 怎麼從上述的 Scope 中取出 Instance

### Sandbox 隔離效果

- 相關資料
  - [依賴注入實戰](https://angular.tw/guide/dependency-injection-in-action)
  - [Dependency injection in action](https://angular.io/guide/dependency-injection-in-action)
- 只要 Component 被 Destroy 後，被 DI 的 instance 也隨之被 Destroy
- DI 的  Instance 隔離效果
  在 Component Attribute providers 指定 Type 後
  該 Component 內引用的 Component
  都可 DI 相同的 Instance

  換言之，providers 指定 Type 就是一個隔離的意思 !
  
- [個人 github 比較範例 -  水平 / 垂直共用與否](https://github.com/ragnakuei/ng-di-service-lifecycle)

```ts
@Component({
  selector: 'app-order-list',
  templateUrl: './order-list.component.html',
  styleUrls: [ './order-list.component.css' ],
  providers : [
      // 指定要被 DI 的 Type 為 Sandbox 效果
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