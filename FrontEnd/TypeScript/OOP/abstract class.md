# abstract class


#### 搭配 angular 範例

- abstract class
  - constructor di 的 modifier 要指定為 protected

- BaseAuthGuardRoleService

    ```ts
    import { Router } from "@angular/router";
    import { UserInfoDtoStore } from "../../store/UserInfoDtoStore";

    export abstract class BaseAuthGuardRoleService {

        protected constructor(protected userInfoDtoStore: UserInfoDtoStore,
                              protected router: Router) {
        }

        AuthRole(role: string): boolean {
            if (this.userInfoDtoStore.UserInfoDto.Role !== role) {
                alert('無權限進入頁面，請重新登入 !');
                this.router.navigate([ '/Account/Login' ]);
                return false;
            }

            return true;
        }
    }
    ```

- AuthGuardRoleManagerService

    - 實作 CanActivate
    - 繼承 BaseAuthGuardRoleService
    - constructor di 的 modifier 要指定為 protected

    ```ts
    import { Injectable } from '@angular/core';
    import { CanActivate, Router } from "@angular/router";
    import { BaseAuthGuardRoleService } from "./BaseAuthGuardRoleService";
    import RoleConst from "../../parameters/RoleConst";
    import { UserInfoDtoStore } from "../../store/UserInfoDtoStore";


    @Injectable({
        providedIn: 'root'
    })
    export class AuthGuardRoleManagerService extends BaseAuthGuardRoleService implements CanActivate {

        constructor(protected userInfoDtoStore: UserInfoDtoStore,
                    protected router: Router) {
            super(userInfoDtoStore,
                router);
        }

        canActivate(): boolean {
            return super.AuthRole(RoleConst.Manager);
        }
    }
    ```

- AuthGuardRoleUserService

    - 實作 CanActivate
    - 繼承 BaseAuthGuardRoleService

    ```ts
    import { Injectable } from '@angular/core';
    import { CanActivate, Router } from "@angular/router";
    import { BaseAuthGuardRoleService } from "./BaseAuthGuardRoleService";
    import RoleConst from "../../parameters/RoleConst";
    import { UserInfoDtoStore } from "../../store/UserInfoDtoStore";

    @Injectable({
        providedIn: 'root'
    })
    export class AuthGuardRoleUserService extends BaseAuthGuardRoleService implements CanActivate {

        constructor(protected userInfoDtoStore: UserInfoDtoStore,
                    protected router: Router) {
            super(userInfoDtoStore,
                router);
        }

        canActivate(): boolean {
            return super.AuthRole(RoleConst.User);
        }
    }
    ```


