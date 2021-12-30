# 讓 Windows Terminal 套用 oh-my-zsh

[參考資料](https://dev.to/rishabk7/beautify-your-terminal-wsl2-5fe2)

### 觀念

- WSL2 裝 zsh theme
- terminal tool 端設定支援 powerline font 及 color schemes

### 步驟

1. [WSL2] 安裝 zsh & oh-my-zsh
   1. 執行 `apt install zsh`
   1. 執行 `curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh >> install.sh`
   1. 執行 `sh install.sh`
   1. 執行 `rm install.sh`
1. [Windows 10] 安裝 Powerline Fonts
   1. 下載 [字型檔案](https://github.com/powerline/fonts/archive/master.zip)
   1. 解壓字型壓縮檔
   1. 以系統管理員身份執行 [PowerShell]
      1. 執行 `Set-ExecutionPolicy Bypass`
      1. 執行上述字型資料夾中的 `install.ps1`，會逐一安裝字型
      1. 執行 `Set-ExecutionPolicy Default`
1. 設定 zshrc
   1. `vim ~/.zshrc`
   1. 將 `ZSH_THEME` 設定為 `agnoster`
   1. (Optional) 設定 Plugins
   
   ```
   plugins=(
     git
     dotenv
     osx
     bundler
     rake
     rbenv
     ruby
   )
   ```
1. 設定 Windows Terminal WSL2  `Ubunttu`
   1. Appearance > Font face > Roboto Mono for Powerline

      profile

      ```js
      {
            "source": "Windows.Terminal.Wsl",
            "name": "Ubuntu-20.04",
            "antialiasingMode": "cleartype",
            "experimental.retroTerminalEffect": false,
            "font": 
            {
               "face": "Roboto Mono for Powerline"
            },
            "guid": "{07b52e3e-de2c-5db4-bd2d-ba144ed6c273}",
            "hidden": false,
            "intenseTextStyle": "bright",
            "useAcrylic": false,

            // 最左方文字顏色，會蓋掉 color schemes 的 foreground
            "foreground":"#000000",
            "colorScheme": "Campbell"
      }
      ```

      color schemes

      ```js
      {
         "name": "Campbell",

         // 最左方文字
         "foreground": "#ffffff",
         "background": "#000000",

         // 左方底色 + 右方文字色
         "black": "#ffffff",

         // 路徑區段底色
         "blue": "#c341ff",

         // 分支區段底色
         "green": "#ff7f00",
         "cyan": "#3A96DD",
         "yellow": "#C19C00",
         "white": "#ffffff",
         "purple": "#881798",
         "red": "#C50F1F",
         "brightBlack": "#767676",
         "brightBlue": "#3B78FF",
         "brightCyan": "#61D6D6",
         "brightGreen": "#16C60C",
         "brightPurple": "#B4009E",
         "brightRed": "#E74856",
         "brightWhite": "#F2F2F2",
         "brightYellow": "#F9F1A5",
         "cursorColor": "#FFFFFF",
         "selectionBackground": "#FFFFFF"
      },
      ```


1. (Optional) Vscode 設定
   
   以 `JetBrains Mono` 來顯示 oh-my-zsh Theme
   
    ```js
      "terminal.integrated.fontFamily": "JetBrains Mono",
      "terminal.integrated.defaultProfile.windows": "Ubuntu-20.04 (WSL)",
      "terminal.integrated.copyOnSelection": true,
      "terminal.integrated.fontSize": 14,
      "terminal.integrated.cursorStyle": "line",
      "workbench.colorCustomizations": {
         // 左方文字、cursor 
         "terminal.foreground": "#c5c5c5",
         
         // 顯示區背景
         "terminal.background": "#000000",

         // 右方文字
         "terminal.ansiBlack": "#ffffff",

         // 路徑區段底色
         "terminal.ansiBlue": "#c341ff",

         // 分支區段底色
         "terminal.ansiYellow": "#ff7f00",
         "editor.background": "#000000",
      },
      "editor.cursorStyle": "line",
    ```

1. 設定完成

