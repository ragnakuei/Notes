# high light

app.module.ts

```typescript
import { NgModule } from "@angular/core";
import { HighLightPipe } from "./pipe/highLight.pipe"; // 2

@NgModule({
  declarations: [
    AppComponent,
    HighLightPipe // 1
  ]
})
export class AppModule {}
```

highLight.pipe.ts

```typescript
import { Pipe, PipeTransform } from "@angular/core";

@Pipe({
  name: "highLight"
})
export class HighLightPipe implements PipeTransform {
  public transform(text: string, search): string {
    if (typeof search === "string") {
      const pattern = search
        .replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")
        .split(" ")
        .filter(t => t.length > 0)
        .join("|");
      const regex = new RegExp(pattern, "gi");

      return search ? text.replace(regex, match => `<b>${match}</b>`) : text;
    }
    return text;
  }
}
```

呼叫 Pipe 的方式

```html
<span
  [innerHTML]="customerOption.CompanyName | highLight: this.orderForm.get('CustomerID').value"
></span>
```
