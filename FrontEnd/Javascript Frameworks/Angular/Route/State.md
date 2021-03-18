# [State]()

目前測試，只可以從 component 給定 state 資料。

routerLink 給定 state 資料一直不成功。

可用來傳遞一些隱藏的參數。

## 從 component 給定 state 資料

- 呼叫端

  ```typescript
  test(){
      const navigationExtras: NavigationExtras = {state: {test: 'This is an example1'}};
      this.router.navigate(['testState'], navigationExtras);
  }
  ```

- route 開啟 component 端

  > 注意：要取得 route state 資料，只能在 constructor 階段就要取出來了。如果從 ngOnInit 取得，就太慢了。

  ```typescript
  example:string;

  constructor(private router: Router) {
      if (this.router.getCurrentNavigation().extras.state != undefined) {
        const navigation = this.router.getCurrentNavigation();
        console.log(navigation.extras.state);
        this.example = navigation.extras.state.testState;
      }
  }
  ```

* [參考資料](https://stackblitz.com/edit/angular-bupuzn?file=src%2Fapp%2Fhello.component.ts)
