# Output

在裡面的 Component 的資料，往呼叫的外部 Comopent 傳

1. 先在 app.module.ts 中註冊 FormsModule

    ```typescript
    import { BrowserModule } from '@angular/platform-browser';
    import { NgModule } from '@angular/core';
    import { AppRoutingModule } from './app-routing.module';
    import { FormsModule } from '@angular/forms'   // 2

    import { AppComponent } from './app.component';
    import { TestComponent } from './test/test.component';
    import { TestChildComponent } from './test/test-child/test-child.component';

    @NgModule({
    declarations: [
        AppComponent,
        TestComponent,
        TestChildComponent
    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        FormsModule                               // 1
    ],
    providers: [],
    bootstrap: [AppComponent]
    })
    export class AppModule { }

    ```

1. 裡面的 Component

    - template

        (change) 裡面的 change 為 event name

        > 完整的 [Event Name List](https://developer.mozilla.org/zh-TW/docs/Web/Events)

        ```html
        <p>test-child works!</p>
        <input type="number" [(ngModel)]="id" (change)="onIdChanged($event)">
        ```

    - component

        HTMLInputElement 是一個 interface

        可以在 [Web APIs](https://developer.mozilla.org/en-US/docs/Web/API) 裡面尋找對應的 Element 結尾的 interface

        > 注意：EventEmitter\<T> 的 namespace 在 @angular/core 中

        當值改變時，透過 EventEmitter\<T>.emit(T) 來給定變更的值

        ```typescript
        import { Component, OnInit, Output, EventEmitter } from '@angular/core';

        @Component({
            selector: 'app-test-child',
            templateUrl: './test-child.component.html',
            styleUrls: ['./test-child.component.css']
        })
        export class TestChildComponent implements OnInit {

            id: number;
            @Output() idChanged: EventEmitter<string> = new EventEmitter<string>();

            constructor() { }

            ngOnInit() {
            }

            onIdChanged(evt : Event) {
                var newValue = (evt.target as HTMLInputElement).value;
                console.log(newValue);
                this.idChanged.emit(newValue);
            }
        }
        ```

1. 外面的 Component

    - template

        idChanged 就是 裡面 component output 的 property name

        onIdChanged 就是此 component 所對應被呼叫的 event method 參數類型就是 event.emit() 所給定的資料型態

        ```html
        <p>test works!</p>
        <p *ngIf="id">Parent Id:{{id}}</p>

        <app-test-child (idChanged)="onIdChanged($event)"></app-test-child>
        ```

    - component

        ```typescript
        import { Component, OnInit } from '@angular/core';

        @Component({
            selector: 'app-test',
            templateUrl: './test.component.html',
            styleUrls: ['./test.component.css']
        })
        export class TestComponent implements OnInit {

            id: number;

            constructor() { }

            ngOnInit() {

            }

            onIdChanged(id : number) {
                console.log(id);
                this.id = id;
            }
        }
        ```
