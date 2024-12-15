# 安裝 Homebrew

### 安裝 Homebrew

至[官網](https://brew.sh/index_zh-tw) 取得安裝指令

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安裝完畢後，會看到下面的訊息
> [User] 會替換成你的使用者名稱

```
==> Next steps:
- Run these commands in your terminal to add Homebrew to your PATH:
    echo >> /Users/kuei/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/kuei/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
- Run brew help to get started
```

接下來就依序執行上述指令
然後輸入指令 brew help，確認是否安裝成功
