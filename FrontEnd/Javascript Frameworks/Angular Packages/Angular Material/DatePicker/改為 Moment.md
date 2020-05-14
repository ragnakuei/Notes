# 改為 Moment

1. 安裝套件 (如果需要時區的判斷)

    > npm i --save @angular/material-moment-adapter moment

1. app.module.ts

    ```typescript
    @angular/material-moment-adapter

    import { MatNativeDateModule, MAT_DATE_FORMATS, MAT_DATE_LOCALE } from "@angular/material/core";     // 2
    import { MatDatepickerModule } from "@angular/material/datepicker";
    import { MatMomentDateModule } from "@angular/material-moment-adapter";   // 2
    import { TW_FORMATS } from './datepicker-formats/TW_FORMATS';

    @NgModule({
    declarations: [
        AppComponent,
    ],
    imports: [
        MatDatepickerModule,
        MatMomentDateModule,                                // 1
    ],
    providers: [
        { provide: MAT_DATE_LOCALE, useValue: 'zh-TW' },
        { provide: MAT_DATE_FORMATS, useValue: TW_FORMATS }
    ],
    bootstrap: [AppComponent]
    })
    export class AppModule {}
    ```

參考資料

- [Choosing a date implementation and date format settings](https://material.angular.io/components/datepicker/overview#choosing-a-date-implementation-and-date-format-settings)