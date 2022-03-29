# ValidateAntiForgeryToken

- Attribute
- 只用來搭配 MVC Form Post 用
- 用 ValidateAntiForgeryToken 的缺點
  - 驗証失敗時，不會產生 Exception 讓 Middleware catch 
  - [解決方式](./IAntiforgery.md#驗証-iantiforgery-可以拋出-antiforgeryvalidationexception-的做法)