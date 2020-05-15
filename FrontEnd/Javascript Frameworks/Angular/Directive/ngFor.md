# ngFor

- Sample1

    用標準的 js 語法取出 index 值

    ```typescript
    @Component({

    selector: 'my-app',

    template: `

        <ul>
        <li *ngFor = "let course of courses, let i = index">
            {{ i + 1 }} - {{ course }}
        </li>
        </ul>
    `,
    })

    export class AppComponent {
    courses = ['course1', 'course2', 'course3'];
    }
    ```

- Sample2

    指定 index 的方式可用 as

    ```typescript
    @Component({

    selector: 'my-app',

    template: `

        <ul>
        <li *ngFor = "let course of courses, index as i">
            {{ i + 1 }} - {{ course }}
        </li>
        </ul>
    `,
    })

    export class AppComponent {
    courses = ['course1', 'course2', 'course3'];
    }
    ```
