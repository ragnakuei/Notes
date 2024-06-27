### 基本觀念

-   VPC network 設定好指定的 network
-   後續 VM 可以指定該 nic 使用上述的 network
-   每個 network 可以設定自己的 firewall
-   firewall 上的每個 rule 可以設定 Targets，這個是 rule 生效的方式，有以下幾種：
    -   All instances in the network
        -   使用方只要使用此 network 就生效 !
    -   Specified target tags
        -   使用方就算使用此 network，還是要指定這邊所設定 Network tag 才會生效 !
    -   Specified service account
        -   只允許指定的 service account，例：Computed Engine 的 service account，可以使用 !

### 進入 network 的方式

-   到 Google Cloud > VPC network > 指定 network
-   到 Google Cloud > Compute Engine > 指定 VM instance > Details > Network interfaces > 指定 network

### 讓外部網路允許指定的 Port 通過的方式

-   進入 network > 切換至 FIREWALLS 頁籤
-   ADD FIREWALL RULE
    -   輸入 Name
    -   Target tags
        -   可以輸入簡單的字串，例：tcp-8080
        -   之後要給其他服務使用時，可以指定此 tag 來允許套用該 rule
            -   就代表該服務是要套用此 rule !
    -   Source IPv4 ranges 輸入指定 IP 範圍
        -   0.0.0.0/0 就是全部開放
    -   Specified protocols and ports
        -   設定指定的 TCP / UDP port
-   儲存
