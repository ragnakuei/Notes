# Injectable

### providedIn

用來指定此 Type 的 Scope，換言之就是可以被哪些地方使用 !

| providedIn | Provider Scope                                  |
| ---------- | ----------------------------------------------- |
| root       | Application / Eager Loaded                      |
| any        | Lazy Loaded / 相同 Module 內還是同一個 Instance |
| @NgModule  | 指定的 NgModule (註 1)                          |

-   註 1：
    等於以下的設定
    1. Service 宣告
        
        ```ts
        @Injectable()
        export class OrderStorageService { }
        ```

    1. 在該指定的 NgModule 中給定 providers`
    
        ```ts
        @NgModule({
            providers: [UserService],
        })
        export class UserModule {}
        ```
