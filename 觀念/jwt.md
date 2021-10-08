# jwt

https://www.imqianduan.com/server/503.html

https://tec.xenby.com/44-%E7%B5%90%E5%90%88-jwt-%E8%88%87-refresh-token-%E9%81%94%E5%88%B0%E9%BB%91%E5%90%8D%E5%96%AE%E5%A4%B1%E6%95%88%E6%A9%9F%E5%88%B6


流程

1. 登入後，同時回傳 (長時效) refresh token 及 (短時效) access token
2. 給定 access token 
   1. 過期
      2. 呼叫 api refresh 並給定 refresh token
      3. 回傳 相同的(長時效) refresh token 及 新的 (短時效) access token
   2. 沒過期
      1. 照允許存取 api
3. refresh token
   1. 過期後
      1. 登出
   2. 沒過期
      1. 回傳 相同的(長時效) refresh token 及 新的 (短時效) access token
4. 為避免 access token 過期後，立即被停用而導致不明錯誤
   1. 允許 access token 過期後的幾秒鐘，仍然可以存取 !
   2. expire 跟 禁止存取 要拆開判斷
