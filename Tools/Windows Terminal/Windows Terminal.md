# Windows Terminal

## 調整字型

在 profiles 中新增以下設定

```json
"fontFace": "JetBrains Mono"
```

## 增加 bash 選項

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
