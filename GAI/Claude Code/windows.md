# windows 環境

參考資料

-   https://www.wenaidev.com/blog/zh-TW/claude-code-windows-install-cursor-integration
-   https://www.youtube.com/watch?v=hI6Wb4zWK3Q
-   https://www.youtube.com/watch?v=hI6Wb4zWK3Q

## 安裝

1. 安裝 WSL
    - wsl --install Ubuntu
1. 上述安裝完，會自動進入 Ubuntu，後續可執行 wsl 指令來進入 Ubuntu 環境
1. 更新 Ubuntu 套件
    - sudo apt update && sudo apt upgrade -y
1. 安裝 Node.js 與 npm
    - sudo apt install nodejs npm -y
1. 安裝 Claude Code
    - sudo npm install -g @anthropic-ai/claude-code
