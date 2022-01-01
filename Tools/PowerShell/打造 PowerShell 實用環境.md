# [打造 PowerShell 實用環境](https://www.facebook.com/will.fans/videos/1534435513578893)

- 要指定字型，無法自訂

### 安裝

1. 安裝 PowerShell Core
   1. 在 pwsh 下執行指令 `winget install Microsoft.PowerShell`
   1. 安裝完畢後，Windows Terminal 會多一組 PowerShell
      1. 將新增的 PowerShell 改為 `PowerShell Core`
      1. 設定 PowerShell Core 為預設的 Profile
   1. 注意：以下的 安裝設定 都要以`系統管理員身份`執行 !

1. 安裝字型
   1. 下載 nerd-fornts 字型 

        https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.1.0

        https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip

    1. 將 Windows Terminal font face 調整成 `CaskaydiaCove Nerd Font Mono`
 
 1. Terminal-Icons Module
    1. 安裝 Module：以系統管理員身份執行 `Install-Module -Name Terminal-Icons -Repository PSGallery -Force`
    1. 套用 Module：以系統管理員身份執行 `Import-Module -Name Terminal-Icons`

    可能會需要執行 `Import-Module -Name Terminal-Icons`

    執行完畢後，執行 `dir` 會發現 檔案/資料夾 都有圖示了 !

    1. 建立啟動設定檔 `notepad $PROFILE`

        ```
        Import-Module -Name Terminal-Icons
        ```

        > 之後設定檔都會在這個檔案中增加內容 !

    1. 重新套用 PROFILE `. $PROFILE`

1. oh-my-posh Module
      
   1. 執行指令 `winget install JanDeDobbeleer.OhMyPosh`
   1. 安裝 Module `Install-Module oh-my-posh -Scope CurrentUser -Force`
   1. 套用 Module `Import-Module oh-my-posh`
   1. 安裝 Module `Install-Module PSReadLine -AllowPrerelease -Force`

   Theme：
   
   1. 在輸入 `Set-PoshPrompt -Theme` 後，就可以用 `Set-PoshPrompt -Theme` 來直接顯示所有的 Theme 效果
   1. [保哥的 Custom oh-my-posh](https://gist.github.com/doggy8088/17e87b9be99639ffb52bbe0709f46b93) / [個人 Fork 版](https://gist.github.com/ragnakuei/15542eabcefd1cf7dcd0f1f8f3d52085)
   1. 安裝保哥的 theme
      1. 下載 
      
         `Invoke-WebRequest -Uri "https://gist.githubusercontent.com/doggy8088/17e87b9be99639ffb52bbe0709f46b93/raw/a1631aeac5638424a20bef54c9f0abc045b9e611/ohmyposhv3-will.omp.json" -OutFile "~/.ohmyposhv3-will.omp.json"`

      1. 套用

         `Set-PoshPrompt -Theme "~/.ohmyposhv3-will.omp.json"`

      1. Theme 說明
         1. 支援 unicode
            1. 可從 html unicode 複製下來直接貼上至 vscode 中
            1. 可以 `\uE738` 方式輸入
         1. 每個區段是一個 segment
            1. style - 影響每個 segment 間的串接顯示方式
               1. powerline - 以 > 方式啟始
               1. diamond - 以 半圓型方式啟始
            1. powerline_symbol - powerline 啟始連接符號
            1. leading_diamond - diamond 前置字元
            1. properties - 該 segment 要顯示的內容與判斷
            1. trailing_diamond - diamond 後置字元

### 設定

1. 參考[這裡](https://gist.github.com/doggy8088/d3f3925452e2d7b923d01142f755d2ae) / [個人 Fork 版](https://gist.github.com/ragnakuei/2b0f1f5bebb98db026fa6a5b45c658b7)
    - F1 - 開啟已輸入未執行的 command help window
    - F7 - 開啟已輸入過的 command list
    - smart quota 功能 
      - 輸入第一個後，自動補上第二個 `"` `' ` `{` `[` `(`
      - 反白選取輸入 quota 會自動在選取文字前後加上
      - 當 auota 沒有包住任何字元時，刪除第一個  quota 會自動刪除第二個字元

1. 參考[這裡](https://gist.github.com/doggy8088/2bf2a46f7e65ae4197b6092df3835f21) / [個人 Fork 版](https://gist.github.com/ragnakuei/9048ee316507191e121b2fab18ea6ffa)
   - Ctrl + Space - 列出所有 argument 並可進行選取
   
1. 參考[這裡](https://gist.github.com/doggy8088/553c4548492b63e4ccbe30d843de85f6) / [個人 Fork 版](https://gist.github.com/ragnakuei/d03e966ef0876a0e927190e99f7861eb)
    - `hosts` - 以 `notepad` 開啟 `c:\windows\system32\drivers\etc\hosts` 檔案
    - `New-Password` - 快速建立長度十的密碼
    - `New-Password -Length n` - 快速建立長度為 N 的密碼

1. 清除 PowerShell 啟始 Logo
   - 開啟 Windows Terminal Settings
   - 在 PowerShell Core 的 Command line 的地方，將 `C:\Program Files\PowerShell\7\pwsh.exe` 加上 `-nologo` 
