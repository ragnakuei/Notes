# [Dialog](https://material.angular.io/components/dialog/api)

> import {MatDialogModule} from '@angular/material/dialog';

- app.module.ts

  要把 DialogComponent 加到以下的地方

  ```typescript
  import { DialogOverviewExample } from "./app/dialog-overview-example";
  import { DialogOverviewExampleDialog } from "./app/dialog-overview-example-dialog"; // 3

  @NgModule({
    imports: [],
    entryComponents: [DialogOverviewExample, DialogOverviewExampleDialog], // 1
    declarations: [DialogOverviewExample, DialogOverviewExampleDialog], // 2
    bootstrap: [DialogOverviewExample],
    providers: []
  })
  export class AppModule {}
  ```

- 呼叫端

  透過 MatDialog.open()

  - 第一個參數 - 給定要顯示的 component

  - 第二個參數 - MatDialogConfig\<T> 用來指定 dialog 屬性

    - width - 寬度
    - data - 要注入的 data，會傳至帶有 @Inject(MAT_DIALOG_DATA) 的 property 中

  component

  ```typescript
  import { Component, Inject } from "@angular/core";
  import {
    MatDialog,
    MatDialogRef,
    MAT_DIALOG_DATA
  } from "@angular/material/dialog";
  import { DialogOverviewExampleDialog } from "./dialog-overview-example-dialog";

  @Component({
    selector: "dialog-overview-example",
    templateUrl: "dialog-overview-example.html",
    styleUrls: ["dialog-overview-example.css"]
  })
  export class DialogOverviewExample {
    animal: string;
    name: string;

    constructor(public dialog: MatDialog) {}

    openDialog(): void {
      const dialogRef = this.dialog.open(DialogOverviewExampleDialog, {
        width: "250px",
        data: { name: this.name, animal: this.animal } // 要注入至 Dialog Component 的資料
      });

      dialogRef.afterClosed().subscribe(result => {
        // 回傳資料是以 dialoag template mat-dialog-close 給定的
        console.log("The dialog was closed");
        this.animal = result;
        console.log(result);
      });
    }
  }
  ```

  template

  ```html
  <ol>
    <li>
      <mat-form-field>
        <input matInput [(ngModel)]="name" placeholder="What's your name?" />
      </mat-form-field>
    </li>
    <li>
      <button mat-raised-button (click)="openDialog()">Pick one</button>
    </li>
    <li *ngIf="animal">You chose: <i>{{animal}}</i></li>
  </ol>
  ```

- Dialog 端

  component

  ```typescript
  import { Component, Inject } from "@angular/core";
  import {
    MatDialog,
    MatDialogRef,
    MAT_DIALOG_DATA
  } from "@angular/material/dialog";
  import { DialogData } from "./DialogData";

  @Component({
    selector: "dialog-overview-example-dialog",
    templateUrl: "dialog-overview-example-dialog.html"
  })
  export class DialogOverviewExampleDialog {
    constructor(
      public dialogRef: MatDialogRef<DialogOverviewExampleDialog>,

      @Inject(MAT_DIALOG_DATA) // 於呼叫端給定至 MatDialogConfig\<T>.data 的資料
      public data: DialogData
    ) {}

    onNoClick(): void {
      this.dialogRef.close();
      // this.dialogRef.close(true);  //  如果需要在這邊回傳處理結果，close() 裡面的參數就是放回傳值。
    }
  }
  ```

  template

  - mat-dialog-close 所指定的就是回傳資料

  ```html
  <h1 mat-dialog-title>Hi {{data.name}}</h1>
  <div mat-dialog-content>
    <p>What's your favorite animal?</p>
    <mat-form-field>
      <input matInput [(ngModel)]="data.animal" />
    </mat-form-field>
  </div>
  <div mat-dialog-actions>
    <button mat-button (click)="onNoClick()">No Thanks</button>
    <button mat-button [mat-dialog-close]="data.animal" cdkFocusInitial>
      Ok
    </button>
  </div>
  ```

- DTO

  ```typescript
  export interface DialogData {
    animal: string;
    name: string;
  }
  ```

參考資料

- https://blog.angular-university.io/angular-material-dialog/
