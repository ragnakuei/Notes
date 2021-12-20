# select option value 設定為 null 的方式


```html
<select (change)="updateEvents()" [formControl]="selectedOption">
    <option [ngValue]="null">{{ 'PRIORITY_ANNUAL_LEAVE.LIST.CHOOSE_TEAM' | translate }}</option>
    <option *ngFor="let option of options"
            [value]="option.value">
    {{ option.text }}
    </option>
</select>
```