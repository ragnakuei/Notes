# custom ngIf

custom-if.directive.ts

```ts
import { Directive, Input, TemplateRef, ViewContainerRef } from '@angular/core';

@Directive({
  selector: '[customIf]',
})
export class CustomIfDirective {
  @Input() set customIf(i : number) {
    const isValid = i % 2 === 0;

    if (isValid) {
      this.container.createEmbeddedView(this.templateRef);
      return;
    }

    this.container.clear();
  }

  constructor(
    private templateRef: TemplateRef<any>,
    private container: ViewContainerRef,
  ) {}
}
```

app.component.html

```html
<div *ngFor="let i of [1,2,3,4,5,6]">
    <span>{{ i }}</span>
    <span *customIf="i" >{{ i }}</span>
</div>
```

app.module.ts

```ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { CustomIfDirective } from 'src/directives/custom-if.directive';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent,

    // 引用
    CustomIfDirective
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```