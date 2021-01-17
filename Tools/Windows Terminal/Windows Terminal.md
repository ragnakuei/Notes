# Windows Terminal

## Profile

### 調整字型

在 profiles 中新增以下設定

```json
"fontFace": "JetBrains Mono"
```

### 增加 bash 選項

此範例的 bash 是透過 git-for-windows 提供的，而不是 WSL2 !

```json
{
    "guid": "{f87acbfb-f554-4eee-8a37-a914f183bca5}",
    "hidden": false,
    "name": "Bash",
    "fontFace": "JetBrains Mono",
    "commandline": "C:/Program Files/Git/bin/bash.exe",
    "startingDirectory" : "%USERPROFILE%"
}
```

### 

- 毛玻璃效果
- 指定起始目錄

```json
{
    "guid": "{B5F1DEB0-1114-4443-B4FC-43334745707C}",
    "name": "xxx",
    "useAcrylic": true,
    "acrylicOpacity": 0.9,
    "commandline": "bash.exe",
    "startingDirectory": "C:/Users/xxxxx/Documents/Projects/xxx",
    "fontFace": "jetbrains mono",
    "hidden": false
}
```

### 待 Study

Appearance

- https://github.com/JanDeDobbeleer/oh-my-posh
  - Theme - Paradox