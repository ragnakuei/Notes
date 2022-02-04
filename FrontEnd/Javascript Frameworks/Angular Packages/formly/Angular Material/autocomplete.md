# autocomplete

[範例](https://stackblitz.com/edit/angular-jey9ef?file=app%2Fapp.component.ts)

[範例](https://stackblitz.com/angular/jyqegnqnpby?file=src%2Fapp%2Fautocomplete-type.component.ts)



```ts
import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { FormControl } from '@angular/forms';
import { MatAutocompleteTrigger } from '@angular/material/autocomplete';
import { MatInput } from '@angular/material/input';

import { Observable } from 'rxjs';
import { startWith, switchMap } from 'rxjs/operators';

import { FieldType } from '@ngx-formly/material';

@Component({
  selector: 'formly-field-autocomplete',
  template: `
    <input
      type="text"
      matInput
      [matAutocomplete]="auto"
      [formControl]="formControl"
      [formlyAttributes]="field"
    />
    <mat-autocomplete #auto="matAutocomplete">
      <mat-option
        *ngFor="let value of filter | async"
        [value]="value"
        (click)="onClickOption(value)"
      >
        {{ value }}
      </mat-option>
    </mat-autocomplete>
  `,
})
export class FormlyFieldAutocomplete
  extends FieldType
  implements OnInit, AfterViewInit
{
  // ...

  ngOnInit() {
      // ...
  }

  ngAfterViewInit() {
    // ...
  }

  onClickOption(value: string) {
    if(this.to.onClickOption) {
      this.to.onClickOption(value);
    }
  }
}
```