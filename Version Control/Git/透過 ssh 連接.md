# 透過 ssh 連接

## git clone

> git clone ssh://<host>/<repo_path>

> git clone ssh://<temp_user>@<host>/<repo_path>

## git push

> git push ssh://<temp_user>@<host>/<repo_path>


## git config

設定指定的 user 來登入 remote

> git config remote.origin.url ssh://<temp_user>@<host>/<repo_path>

### 與 GitLab 溝通

[GitLab 說明頁面](https://gitlab.iinumbers.net/help/ssh/README)

1. 先建立 RSA Key Pair

    ```
    ssh-keygen -t rsa -b 2048 -C "自己的帳號"
    ```

   - 輸入 PassPhrase 
     - 可以輸入空白，這樣 git 與 remote 溝通時，就不用輸入 passphrase 了 !

1. 複製 \home directory\.ssh\id_rsa.pub 中的內容

1. 貼上至 GitLab Account Settings > SSH Keys > Key 中
