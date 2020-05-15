# DatePicker

> import {MatDatepickerModule} from '@angular/material/datepicker';

1. 基本語法

    ```html
    <mat-form-field>
    <input
        matInput
        [matDatepicker]="OrderDatePicker"
        formControlName="OrderDate"
        placeholder="OrderDate"
    />
    <mat-datepicker-toggle matPrefix [for]="OrderDatePicker"></mat-datepicker-toggle>
    <mat-datepicker #OrderDatePicker></mat-datepicker>
    </mat-form-field>
    ```

1. 可用[快捷鍵](https://material.angular.io/components/datepicker/overview#keyboard-interaction)控制

1. 參考資料

- [[Angular Material完全攻略] Day 11 - 打造問卷頁面(3) - Datepicker](https://ithelp.ithome.com.tw/articles/10194720)
