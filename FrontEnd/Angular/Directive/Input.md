# Input

從 外面的 Component 把值傳進 裡面的 Component

> 注意：這個方式只適用於 呼叫裡面 component selector 的方式。不適用於 router-outlet

外面的 Component

- component

    ```typescript
    import { Component, OnInit } from '@angular/core';

    @Component({
        selector: 'app-test',
        templateUrl: './test.component.html',
        styleUrls: ['./test.component.css']
    })
    export class TestComponent implements OnInit {

        id: string;

        constructor() { }

        ngOnInit() {
            this.id = "a";
        }
    }
    ```

- template

    指定裡面 component selector 並給定值

    ```html
    <p>test works!</p>
    <p *ngIf="id">Parent Id:{{id}}</p>

    <app-test-child [id]=this.id ></app-test-child>
    ```

裡面的 Component

- component

    ```typescript
    import { Component, OnInit, Input, Output } from '@angular/core';

    @Component({
        selector: 'app-test-child',
        templateUrl: './test-child.component.html',
        styleUrls: ['./test-child.component.css']
    })
    export class TestChildComponent implements OnInit {

        @Input() id : string;

        constructor() { }

        ngOnInit() {
        }
    }
    ```

- template

    ```html
    <p>test-child works!</p>
    <p>Child Id:{{id}}</p>
    ```
