# [Sample](https://www.typescriptlang.org/docs/handbook/asp-net-core.html)

- [Sample](#sample)
  - [1. 建立 Asp.Net Core 專案](#1-%e5%bb%ba%e7%ab%8b-aspnet-core-%e5%b0%88%e6%a1%88)
  - [2. 範本選擇 Empty](#2-%e7%af%84%e6%9c%ac%e9%81%b8%e6%93%87-empty)
  - [3. 安裝套件](#3-%e5%ae%89%e8%a3%9d%e5%a5%97%e4%bb%b6)
  - [4. Startup.Configure() 的內容改成以下語法](#4-startupconfigure-%e7%9a%84%e5%85%a7%e5%ae%b9%e6%94%b9%e6%88%90%e4%bb%a5%e4%b8%8b%e8%aa%9e%e6%b3%95)
  - [5. 於專案內，新增 scripts 資料夾](#5-%e6%96%bc%e5%b0%88%e6%a1%88%e5%85%a7%e6%96%b0%e5%a2%9e-scripts-%e8%b3%87%e6%96%99%e5%a4%be)
  - [6. 新增 scripts/app.ts](#6-%e6%96%b0%e5%a2%9e-scriptsappts)
  - [7. 新增 scripts/tsconfig.json](#7-%e6%96%b0%e5%a2%9e-scriptstsconfigjson)
  - [8. 專案根目錄下，新增 package.json](#8-%e5%b0%88%e6%a1%88%e6%a0%b9%e7%9b%ae%e9%8c%84%e4%b8%8b%e6%96%b0%e5%a2%9e-packagejson)
  - [9. 在 package.json 上面，按下滑鼠右鍵，選擇`還原封裝(Restore Packages)`](#9-%e5%9c%a8-packagejson-%e4%b8%8a%e9%9d%a2%e6%8c%89%e4%b8%8b%e6%bb%91%e9%bc%a0%e5%8f%b3%e9%8d%b5%e9%81%b8%e6%93%87%e9%82%84%e5%8e%9f%e5%b0%81%e8%a3%9drestore-packages)
  - [10. 專案根目錄下，新增 gulpfile.js](#10-%e5%b0%88%e6%a1%88%e6%a0%b9%e7%9b%ae%e9%8c%84%e4%b8%8b%e6%96%b0%e5%a2%9e-gulpfilejs)
  - [11. 於`專案根目錄`下，建立 `wwwroot` 資料夾](#11-%e6%96%bc%e5%b0%88%e6%a1%88%e6%a0%b9%e7%9b%ae%e9%8c%84%e4%b8%8b%e5%bb%ba%e7%ab%8b-wwwroot-%e8%b3%87%e6%96%99%e5%a4%be)
  - [12. 建立 wwwroot/index.html](#12-%e5%bb%ba%e7%ab%8b-wwwrootindexhtml)
  - [13. 執行專案，瀏覽 /index.html](#13-%e5%9f%b7%e8%a1%8c%e5%b0%88%e6%a1%88%e7%80%8f%e8%a6%bd-indexhtml)

---

## 1. 建立 Asp.Net Core 專案

## 2. 範本選擇 Empty

## 3. 安裝套件

- Microsoft.AspNetCore.StaticFiles
- Microsoft.TypeScript.MSBuild

## 4. Startup.Configure() 的內容改成以下語法

```csharp
public void Configure(IApplicationBuilder app, IHostingEnvironment env)
{
    if (env.IsDevelopment())
    {
        app.UseDeveloperExceptionPage();
    }

    app.UseDefaultFiles();
    app.UseStaticFiles();
}
```

## 5. 於專案內，新增 scripts 資料夾

## 6. 新增 scripts/app.ts

```js
function sayHello() {
    const compiler = (document.getElementById("compiler") as HTMLInputElement).value;
    const framework = (document.getElementById("framework") as HTMLInputElement).value;
    return `Hello from ${compiler} and ${framework}!`;
}
```

## 7. 新增 scripts/tsconfig.json

```json
{
    "compilerOptions": {
    "noEmitOnError": true,
    "noImplicitAny": true,
    "sourceMap": true,
    "target": "es6"
    },
    "files": ["./app.ts"],
    "compileOnSave": true
}
```

## 8. 專案根目錄下，新增 package.json

devDependencies 的內容，以下面的語法取代

```json
{
    "version": "1.0.0",
    "name": "asp.net",
    "private": true,
    "devDependencies": {
        "gulp": "4.0.2",
        "del": "5.1.0"
    }
}
```

## 9. 在 package.json 上面，按下滑鼠右鍵，選擇`還原封裝(Restore Packages)`

還原套件後，檢查 Dependencies > npm 的套件狀況是否正常

## 10. 專案根目錄下，新增 gulpfile.js

```js
/// <binding AfterBuild='default' Clean='clean' />
/*
This file is the main entry point for defining Gulp tasks and using Gulp plugins.
Click here to learn more. http://go.microsoft.com/fwlink/?LinkId=518007
*/

var gulp = require('gulp');
var del = require('del');

var paths = {
    scripts: ['scripts/**/*.js', 'scripts/**/*.ts', 'scripts/**/*.map'],
};

gulp.task('clean', function () {
    return del(['wwwroot/scripts/**/*']);
});

gulp.task('default', function () {
    gulp.src(paths.scripts).pipe(gulp.dest('wwwroot/scripts'))
});
```

檔案建立後，可在 gulpfile.js 上面按下滑鼠右鍵，選擇`工作執行器總管(Task Runner Explorer.)`來檢視工作

> 工作是指 `path 內指定的檔案是否有複製到 wwwroot/scripts 中`

## 11. 於`專案根目錄`下，建立 `wwwroot` 資料夾

## 12. 建立 wwwroot/index.html

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <script src="scripts/app.js"></script>
    <title></title>
</head>
<body>
    <div id="message"></div>
    <div>
        Compiler: <input id="compiler" value="TypeScript" onkeyup="document.getElementById('message').innerText = sayHello()" /><br />
        Framework: <input id="framework" value="ASP.NET" onkeyup="document.getElementById('message').innerText = sayHello()" />
    </div>
</body>
</html>
Test #
```

## 13. 執行專案，瀏覽 /index.html

在 Textbox 中，輸入`文字`後，透過 typescript 顯示的文字才會顯示出來
