# 前端 Angular 後端 WebApi 套用 CSRF Token

開發階段
- 讓 Angular 與 Web Api 不同台 Host，所以必須設定 CORS 與 Cross Domain Cookie
  - Angular
    - 設定 webpack development server proxy 功能指向後端

上正式機時
- 會讓 Angular 與 Web Api 同站台，所以正式機不需要 CORS 與 Cross Domain Cookie
- 後端
  - 要設定 Static Files
  - 要設定取得 index.html 時，要給定 CSRF Token
  - api/Test/Post1() 不能被存取
- 前端
  - 改為直接從 Cookie 取出 CSRF Token

範例在[這](https://github.com/ragnakuei/CrossSiteCsrfToken)
> 下方都不給 code 了 !

CSRF Cookie + Token 流程
- 正式機
  - 在取得 angular index.html 的同時，後端就會給定 CSRF Cookie + Token
- 測試機
  - angular 從 api/index.html 取得 CSRF Cookie + Token
    - 設定 webpack development server proxy ，將 api/index.html 指向後端的 index.html 來取得 取得 CSRF Cookie + Token

---

### 後端 WebApi

後端的設計
- 除了取得 index.html 外
  - 全部用 Http Post
  - 全部必須進行 CSRF Token 驗証

#### 自訂 CSRF 驗証 Filter

後端的 CSRF 驗証無法使用預設的，原因是：
- 因為 Startup.ConfigureService() 中 **AddControllersWithViews()** 所設定的才有加入 CSRF Token 驗証實作，這個實作包含了
  - Filter
    - AutoValidateAntiforgeryToken()
    - ValidateAntiforgeryToken()
- 但是 **AddControllers()** 則沒有加入 CSRF Token 驗証實作，如果直接加上 Filter，就會產生 Exception

所以後端 WebApi 只好加上自制 CSRF Token 驗証實作

而這個驗証驗實的範例就是 **CustomValidateAntiforgeryFilter**

其中比較關鍵的
- 未給定 CustomValidateAntiforgeryAttribute 視為 IsValidate = true
- 透過 Rseponse Cookie 來給定 Token
  - Cookie 就必須是 Cross Domain，才能讓前端框架讀到

#### Startup 設定

範例中，把 Antiforgery Cookie Name 跟 Header Name 都改掉，才能分得清楚其中的對應關係

Startup 其中比較關鍵的部份，寫在註解中

##### AssignCsrfTokenForIndexHtmlMiddleware

在取得 / 或 index.html 時，就給定 CSRF Cooke + Token

##### SpaMiddleware

讓不是 api 開頭的 route 都導到 index.html

##### UseSpaStaticFiles

讓 web api 支援被讀取 特定的 wwwroot 資料夾

要注意

> 這邊列的實體資料夾，都必須存在，否則會啟動失敗 !

### Const

這個設定的用意是讓相關的參數能統一 review，且可以被追縱 !

---

### 前端 Angular

先加上測試環境可以直接 proxy 至後端 WebApi 的設定，可以參考[這](../../../../FrontEnd/Javascript%20Frameworks/Angular/開發階段%20設定%20proxy%20server.md)

再讓 fetch 可以套用 Cross Domain Cookie，實作可以參考[這](../Cookie/Cross%20Domain%20設定.md#JavaScript%20fetch)

在 App Component 引用 TestComponent

TestComponent 再引用 FetchService

FetchService 
- CSRF Token 取值流程
  - 從 CSRF Token Cookie 取出 Token 
  - 如果上述沒有值，以 Http Get 呼叫後端 index.html 來讓後端給定 CSRF Cookie + Token
    - Production 環境，會在一開始進入 index.html 時，就取得 CSRF Cookie + Token
