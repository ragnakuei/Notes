# 防止 Unsave Changes

### 範例一

-   待解決

    -   新增有效
    -   編輯無效

-   Route 設定

    ```ts
    import { NgModule } from '@angular/core';
    import { RouterModule, Routes } from '@angular/router';

    import { DeactivateGuardService } from '@management/services/deactivate-guard.service';
    import { TestListComponent } from './test-list/test-list.component';
    import { TestFormComponent } from './test-form/test-form.component';

    const routes: Routes = [
        {
            path: '',
            component: TestListComponent,
        },
        {
            path: 'create',
            component: TestFormComponent,
        },
        {
            path: ':id/update',
            component: TestFormComponent,
            canDeactivate: [DeactivateGuardService],
        },
    ];

    @NgModule({
        imports: [RouterModule.forChild(routes)],
        exports: [RouterModule],
        providers: [DeactivateGuardService],
    })
    export class TestRoutingModule {}
    ```

-   Guard 設定

    ```ts
    import { Injectable } from '@angular/core';
    import { CanDeactivate } from '@angular/router';

    import { Observable } from 'rxjs';

    export interface IDeactivateComponent {
        canExit: () => Observable<boolean> | Promise<boolean> | boolean;
    }

    @Injectable({
        providedIn: 'root',
    })
    export class DeactivateGuardService
        implements CanDeactivate<IDeactivateComponent>
    {
        public canDeactivate(
            component: IDeactivateComponent,
        ): Observable<boolean> | Promise<boolean> | boolean {
            return component.canExit ? component.canExit() : true;
        }
    }
    ```

-   Component 設定

    ```ts
    import { Component, OnInit } from '@angular/core';
    import {
        FormArray,
        FormBuilder,
        FormGroup,
        Validators,
    } from '@angular/forms';
    import { ActivatedRoute, CanDeactivate, Router } from '@angular/router';

    import { IDeactivateComponent } from '../services/deactivate-guard.service';

    @Component({
        selector: 'test-form',
        templateUrl: './test-form.component.html',
        styleUrls: ['./test-form.component.scss'],
    })
    export class FormComponent implements OnInit, IDeactivateComponent {
        form!: FormGroup;
        id!: string;
        isUpdate = false;

        constructor(
            private formBuilder: FormBuilder,
            private route: ActivatedRoute,
            private router: Router,
        ) {}

        ngOnInit(): void {
            // ...
        }

        async submitForm(): Promise<void> {
            // ...

            this.form.reset();

            await this.router.navigate(['/test'], { relativeTo: this.route });
        }

        public canExit(): boolean {
            console.log('this.form.touched', this.form.touched);
            console.log('this.form.untouched', this.form.untouched);
            console.log('this.form.dirty', this.form.dirty);

            return this.form.dirty
                ? window.confirm(
                      'You have unsaved changes.  Are you sure you want to leave the page?',
                  )
                : true;
        }
    }
    ```
