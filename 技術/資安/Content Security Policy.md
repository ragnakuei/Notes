參考資料

-   [HackMD - Markdown 協作知識庫](https://hackmd.io/@Eotones/BkOX6u5kX)

SRI ( integrity ) 不採用的原因：

-   跟這個參考資料 [防止 CDN 來源的檔案被 CDN 業者篡改 (Subresource Integrity (SRI))](https://hackmd.io/@Eotones/BkOX6u5kX#%E9%98%B2%E6%AD%A2CDN%E4%BE%86%E6%BA%90%E7%9A%84%E6%AA%94%E6%A1%88%E8%A2%ABCDN%E6%A5%AD%E8%80%85%E7%AF%A1%E6%94%B9-Subresource-Integrity-SRI) 的想法相同

重點方向

-   default-src ‘none’
-   object-src ‘none’
-   Frame-Ancestores ‘none’
-   connect-src ‘self’
    -   為了讓 ajax 可以跟自己站台溝通用
-   img-src ‘self’ data:
    -   data: 必須要開放，否則 bootstrap 的 svg、base64 image 都不能用 !
-   script-src
    -   不能用 ‘self’
    -   用 nonce
-   style-src
    -   可以用 ‘self’
    -   用 nonce


---

輕前端 vue 可以過 AppScan CSP 的方式：

script-src

-   用 nonce
-   unsafe-eval
-   unsafe-inline

其中的觀念：

self 被 AppScan 認定為不夠安全的 policy
所以再把範圍縮小，只能在給定 nonce 的部份來執行 unsafe-eval / unsafe-inline js script
nonce 其中一個要求是：每次 request 都必須更換其隨機值
就算加上 unsafe-eval / unsafe-inline 也仍然在開發者可控的範圍內來執行 vue
