## 基本觀念

-   前置動作 card:9ygnxc06e0gwa827hmw3qy48k3 設定好 port 22 通過 !

-   設定完畢後，再給定 ssh public key 就可以了 !

## 使用 ssh key

原理：跟原本 ssh authorized_keys 運作的方式一樣，將本機的 ssh public key 放到 Linux VM instance 設定中，就等於允許該 VM 允許本機存取 !

### 本機為 mac os

-   以指令 ssh-keygen 產生 ssh key pair
-   將所產生的 public key ( 隨機檔名預計是 id_xxxxxxx.pub ) 內容複製下來
-   到 Google Cloud > Compute Engine > VM Instance > 指定 VM > Details > Edit > Security and access > SSH Keys 中，新增 item 並貼上剛才的 public key 內容 !
-   儲存
-   在本機直接以 ssh 至上述 VM Instance 的 public ip，不需密碼就可以直接登入 !
