# 將特定 App 的暫存資料夾移至指定的資料夾中

取消 symbolic link：
> unlink ~/Library/Caches/[target]

## Brave

### 影響範圍

- 下載檔案時，會先儲存至 Cache 中，再將檔案移至指定的資料夾中

### 操作步驟

來源資料夾：~/Library/Caches/BraveSoftware
移轉目的地：/Volumes/Transcend_1TB/Caches/BraveSoftware

將快取資料夾移動到移轉目的地中：
> mv ~/Library/Caches/BraveSoftware /Volumes/Transcend_1TB/Caches/BraveSoftware

建立 Symbolic Link：
注意：左方有 BraveSoftware 的資料夾，右方也有
> ln -s /Volumes/Transcend_1TB/Caches/BraveSoftware ~/Library/Caches/BraveSoftware 

最終要確保
/Volumes/Transcend_1TB/Caches/BraveSoftware/Brave-Browser/Default/Cache/Cache_Data
這個資料夾存在，且有檔案存在其中

### 驗証方式

開啟 Brave App 後，以指令 `ls -alrt` 檢視 ~/Library/Caches/BraveSoftware/Brave-Browser/Default/Cache/Cache_Data
確保有檔案會是最新的修改時間，就代表設定成功 !


## JetBrains

### 操作步驟

來源資料夾：~/Library/Caches/JetBrains
移轉目的地：/Volumes/Transcend_1TB/Cache/JetBrains

將快取資料夾移動到移轉目的地中：
> mv ~/Library/Caches/JetBrains /Volumes/Transcend_1TB/Cache/JetBrains

建立 Symbolic Link：
注意：左方有 JetBrains 的資料夾，右方也有
> ln -s /Volumes/Transcend_1TB/Cache/JetBrains ~/Library/Caches/JetBrains

最終要確保
/Volumes/Transcend_1TB/Caches/JetBrains/Toolbox
確保有檔案會是最新的修改時間，就代表設定成功 !

### 驗証方式

開啟 JetBrains Toolbox App 後
以指令 `ls -alrt` 檢視 ~/Library/Caches/JetBrains/Toolbox/Download/ 中的資料有最新的修改時間，就代表設定成功 !

## Line

### 操作步驟

來源資料夾：~/Library/Caches/JetBrains
移轉目的地：/Volumes/Transcend_1TB/Cache/JetBrains

將快取資料夾移動到移轉目的地中：
> mv ~/Library/Caches/JetBrains /Volumes/Transcend_1TB/Cache/JetBrains

建立 Symbolic Link：
注意：左方有 JetBrains 的資料夾，右方也有
> ln -s /Volumes/Transcend_1TB/Cache/JetBrains ~/Library/Caches/JetBrains

最終要確保
/Volumes/Transcend_1TB/Caches/JetBrains/Toolbox
確保有檔案會是最新的修改時間，就代表設定成功 !

### 驗証方式

開啟 JetBrains Toolbox App 後
以指令 `ls -alrt` 檢視 ~/Library/Caches/JetBrains/Toolbox/Download/ 中的資料有最新的修改時間，就代表設定成功 !

