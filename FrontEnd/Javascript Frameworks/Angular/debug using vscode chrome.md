# debug using vscode chrome

1. 安裝 VScode 套件 [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)

1. 於 vscode 中，按下 \<Ctrl> + \<p>，輸入 `> debug launch.json` 

1. 選擇 Chrome

1. 把 lanunch.json 中的內容換成以下，主要是 url、webRoot、userDataDir、sourceMapPathOverrides

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "chrome",
      "request": "launch",
      "name": "Launch Chrome against localhost",
      "url": "http://localhost:4200",
      "webRoot": "${workspaceRoot}/src",
      "userDataDir": "${workspaceRoot}/.chrome",
      "sourceMapPathOverrides": {
        "webpack:///./src/*": "${webRoot}/*"
      }
    }
  ]
}
```

1. 執行 Angular 專案 ng serve

1. 於 vscode 按下 \<F5> 就會開啟 Chrome 

1. 接下來，就可以下中斷點進行 Debug

[參考資料](https://coffee0127.github.io/blog/2017/06/11/Angular-debug-with-VS-Code/)