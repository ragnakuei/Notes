# [State]()

目前測試，只可以從 component 給定 state 資料。

routerLink 給定 state 資料一直不成功。

可用來傳遞一些隱藏的參數。

## 從 component 給定 state 資料

- 呼叫端

  下面二個語法都可以

  ```typescript
  test(){
      const navigationExtras: NavigationExtras = {state: {test: 'This is an example1'}};
      this.router.navigate(['testState'], navigationExtras);
  }

  test(){
      this.router.navigate(['testState'], {
        // relativeTo: this.route,
        state: {test: 'This is an example1'},
      });
  }
  ```

- route 開啟 component 端

  - 從 route 取出 state 的頁面，最好不要設定 route 讓使用者可以直接以 url 存取
    - 原因是：因為直接以 url 進入頁面後，會沒有經過給定 route state 動作，而導致取出的 route state 是 null !

  - 方式一：
    注意：下面的做法，要取得 route state 資料，只能在 constructor 階段就要取出來了。如果從 ngOnInit 取得，就太慢了。

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

  - 方式二：

    直接從 history.state 轉成對應的型別

    ```ts
    ngOnInit(): void {
      const dto = history.state as Dto;
    }
    ```


* [參考資料](https://stackblitz.com/edit/angular-bupuzn?file=src%2Fapp%2Fhello.component.ts)
