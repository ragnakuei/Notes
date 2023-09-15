# 無法以 https 瀏覽 localhost 網頁

#### 會出現以下錯誤訊息
> NET::ERR_CERT_AUTHORITY_INVALIDÒ

#### 解決方式

1. 開啟 chrome://flags/#allow-insecure-localhost
1. 將 `Allow invalid certificates for resources loaded from localhost` 設定為 `Enabled`

註：如果是 Edge 的話，則是開啟 edge://flags/#allow-insecure-localhost