# [ViewChild](https://angular.io/guide/component-interaction#parent-calls-an-viewchild)

二種語法

- 語法一

    適用於 Component 內

    ```typescript
    @ViewChild(HelloComponent, {static: false}) hello: HelloComponent;
    ```

- 語法二

    適用於 View Directive

    ```typescript
    @ViewChild('pRef', {static: false}) pRef: ElementRef;
    ```

    ```html
    <p #pRef>
        Start editing to see some magic happen :)
    </p>
    ```

    [Sample](https://stackblitz.com/edit/angular-viewchild-example?file=app%2Fapp.component.ts)

