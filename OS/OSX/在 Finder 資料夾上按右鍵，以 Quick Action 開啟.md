# 在 Finder 資料夾上按右鍵，以 Quick Action 開啟

### Visual Studio Code
1. 開啟 Shortcuts.app
1. 點選 Quick Actions
1. 點選右邊的 + 號 (新增)
1. 上方的 Shortcut Name 輸入 Open in VSCode
1. Receive 先取消全選，再勾選 Files 跟 Folders 
1. 右方工具列選擇 Categories > Scripting > Run Shell Script ( 會需要開啟權限 )
1. Script 輸入 `open -n -b "com.microsoft.VSCode" --args "$*"`
1. Input > Type 選擇 Folder > Get 選擇 File Path
1. Pass Input 選擇 as arguments
1. Shortcuts.app 設定完成
1. 開啟 System Settings > Privacy & Security > Others 區塊中的 Extensions > Finder
1. 選擇剛才建立的 Open in VSCode
1. 設定完成 !

### Rider
步驟同上，但 Script 輸入以下其中一個就可以了 !
- open -a ~/Library/Application\ Support/JetBrains/Toolbox/scripts/rider --args "$*"
- open -a "/Users/kuei/Library/Application Support/JetBrains/Toolbox/scripts/rider" --args "$*"
- open -a /Users/kuei/Library/Application\ Support/JetBrains/Toolbox/scripts/rider --args "$*"

以下的是不行的，原因猜測是 以 " " 包住的路徑，讀不到 ~/ 的部分
- open -a "~/Library/Application Support/JetBrains/Toolbox/scripts/rider.app" --args "$*"