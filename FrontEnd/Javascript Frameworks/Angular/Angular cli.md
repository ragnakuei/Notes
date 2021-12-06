# [Angular CLI](https://angular.io/cli)

## [new](https://angular.io/cli/new)

-   ng new MyApp --minimal=true 建立不包含測試的 App

## [generate](https://angular.io/cli/generate)

### [generate module](https://angular.io/cli/generate#module)

#### ng g m Test   
  - 建立 src/app/test/test.module.ts

#### ng g m Order --flat                                                               
  - 建立 src/app/test.module.ts
  - 不會建立 module 名稱的資料夾

#### ng g m pages/table         
  - 建立 src/app/pages/table/table.module.ts

#### ng g m pages/table --routing=true --routing-scope=Child        
  - ★
  - 建立 src/app/pages/table/table.module.ts
  - 建立 src/app/pages/table/table-routing.module.ts
  - 設定 table.module.ts 引用 table-routing.module.ts
  - routing 以 **RouterModule.forChild(routes)** 這個方式 import

    ```ts
    const routes: Routes = [{ path: '', component: TableComponent }];

    @NgModule({
        // 已有 --routing-scope=Child 的效果 !
        imports: [RouterModule.forChild(routes)],
        exports: [RouterModule]
    })
    export class TableRoutingModule { }
    ```

#### ng g m pages/table/table --flat --routing=true --routing-scope=Child              
  - 與上面項目同義

#### ng g m pages/table2 --module=pages/table/Table
  - 建立 src/app/pages/table2/table2.module.ts
  - 設定 table.module.ts 引用 table2.module.ts
                                                                                  
#### ng g m pages/order --module=app --route=order
  - ★★★
  - 建立 src/app/pages/order/order.module.ts
  - 建立 src/app/pages/order/order-routing.module.ts
  - 設定 order.module.ts 引用 order-routing.module.ts
  - routing 以 **RouterModule.forChild(routes)** 這個方式 import

    ```ts
    const routes: Routes = [{ path: '', component: OrderComponent }];

    @NgModule({
        // 已有 --routing-scope=Child 的效果 !
        imports: [RouterModule.forChild(routes)],
        exports: [RouterModule]
    })
    export class OrderRoutingModule { }
    ```
  - 在 app.module.ts 所定義的 routing (app-routing.module.ts) 內，建立 route

    ```ts
    const routes: Routes = [
        // 會建立下面這一行
        { path: 'order', loadChildren: () => import('./pages/order/order.module').then(m => m.OrderModule) },
    ];
    ```


### component

-   ng g c Test --skip-tests=true

## [serve](https://angular.io/cli/serve)

-   ng serve --port 4201 以 port 4201 啟動網站
