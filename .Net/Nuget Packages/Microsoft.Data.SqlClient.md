# Microsoft.Data.SqlClient

為 System.Data.SqlClient 的替代套件

---

Q：出現 此憑證鏈結是由不受信任的授權單位發出的 的錯誤訊息 !

A：連線字串，加上 TrustServerCertificate=true 就可以，但建議只用於開發環境，因為這項設定會忽略連到 DB 的 SSL Certificate Validation !
