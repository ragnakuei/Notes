# 無法啟動 IIS Express (三)

關鍵字：0x80070020

```
Unable to launch the IIS Express Web server.

Failed to register URL "http://localhost:63591/" for site "xxxxxx" application
"/". Error description: The process cannot access the file because it is being
used by another process. (0x80070020)
```

[解法](https://stackoverflow.com/questions/29116292/unable-to-launch-the-iis-express-web-server-in-visual-studio)


已嘗試之解法：

1. 以系統管理員身分執行 cmd, 執行以下指令

```
net stop winnat
net start winnat
```
