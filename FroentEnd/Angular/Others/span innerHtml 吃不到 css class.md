# span innerHtml 吃不到 css class

- 原因

    正常的情況下，component css 會加上亂數字元，避免不同 component 間的相同 css class name 共用而導致衝突

    > Keyword： `Shadow DOM`

    但是在一些特殊情況下，就會需要直接從 component 直接給定 css class

    這樣做時，angular 就無法給定對應的 css class 亂數字元

- 解決方式

    這樣做，就不會在該 component css 上加上亂數字元 !

    但是，要注意的 parent route component 與 child route component 儘量如果要同時都帶上這個設定，要注意名稱是否衝突。

    ```typescript
    import { Component, ViewEncapsulation } from "@angular/core";  // 1

    @Component({
        encapsulation: ViewEncapsulation.None,                     // 2
        selector: "app-order-create",
        styleUrls: ["./order-create.component.css"],
        templateUrl: "./order-create.component.html"
    })
    export class OrderCreateComponent implements OnInit {

    }
    ```

[參考資料](https://stackoverflow.com/questions/44210786/style-not-working-for-innerhtml-in-angular-2-typescript)