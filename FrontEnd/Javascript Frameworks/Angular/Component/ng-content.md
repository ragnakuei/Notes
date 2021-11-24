# ng-content


#### [新版做法](https://angular.io/guide/content-projection)

- component 宣告

    ```ts
    import { Component, Input, OnInit } from '@angular/core';
    import { FormGroup } from '@angular/forms';

    @Component({
    selector: 'test',
    templateUrl: './test.component.html',
    styleUrls: ['./test.component.scss']
    })
    export class TestComponent implements OnInit {
    @Input() startIdName: string = 'startAt';
    @Input() endIdName: string = 'endAt';

    constructor() { }

    ngOnInit(): void {
    }

    }

    ```

    ```html
    <div>
        <input
            [id]="startIdName"
            [name]="startIdName"
        />
        <ng-content select="[between]"></ng-content>
        <input
            [id]="endIdName"
            [name]="endIdName"
        />
    </div>
    ```

- 呼叫方式

    ```html
    <test>
        <label between>~</label>
    </test>
    ```

#### 舊版做法

讓 ng-content 所在的 component (template component) 可以把呼叫點的 directive 的 innter html 放進 ng-content 中

其餘用法與 component 一樣

參考資料：

- https://ithelp.ithome.com.tw/articles/10187991
