# Certitifacte

## 用途

- 用於非 Release 的環境


## 建立 localhost 開發用的 SSL 憑證

```
IisExpressAdminCmd.exe setupsslUrl -url:https://localhost:8080 -UseSelfSigned
```

目前測試， 80 port 無法使用

