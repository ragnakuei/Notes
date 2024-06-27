### 前置動作：依照 [這個](讓本機%20ssh%20可以連到%20Linux%20VM%20的方式.md) 設定好 port 80 / 443 可以通過 !

### 方式

-   到 Google Cloud > Compute Engine > VM Instance > 指定 VM > Details > Edit > Networking > Firewalls 中
    -   勾選 Allow HTTP trafic 或 Allow HTTPS trafic
    -   儲存
-   就可以讓外部 IP 直接連至該 VM 的 80 / 443 port !
