# module

- 讓原本單一 Declarations 的 Component / Directive 可以被多個地方引用

### 新增 module

1. 用 angular cli `ng g m [ModuleName] --flat` 產生 **.module.ts** 檔
1. 可以將 **.module.ts** 檔 放至指定的資料夾內，做區隔
1. 增加 route 設定
   1. 可以從 AppRoutingModule 複製出來
   2. 以下 import 的語法要注意，不要用 RouterModule.forRoot(routes)，而是要用 **RouterModule.forChild(routes)**

   ```ts
   @NgModule({
     imports: [ RouterModule.forChild(routes) ],
     exports: [ RouterModule ]
   })
     export class TestRoutingModule {
   }
   ```
1. Component 後續新增比照原本 AppModule 內的套用方式 !

