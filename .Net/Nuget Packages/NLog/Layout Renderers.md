# Layout Renderer

設定檔裡面會用到的保留字，以 ${ } 包住變數

[官方資料](https://github.com/NLog/NLog/wiki/Layout-renderers)

以下僅列出部份


| Parameter             | 說明                                   | 備註 |
| --------------------- | -------------------------------------- | ---- |
| ${basedir}            | 應用程式所在的資料夾                   |      |
| ${callsite}           | 日誌來源的類別名稱、方法名稱和來源資訊 | 必填 |
| ${date}               | 目前日期和時間                         |      |
| ${exception}          | 例外的訊息                             | 必填 |
| ${level}              | 日誌的級別                             | 必填 |
| ${logger}             | 日誌的來源                             |      |
| ${longdate}           | 長日期格式，yyyy-MM-dd HH:mm:ss.mmm    |      |
| ${machinename}        | 電腦名稱                               | 必填 |
| ${message}            | 日誌的內容                             |      |
| ${newline}            | 換行符號                               |      |
| ${shortdate}          | 短日期格式  yyyy-MM-dd                 |      |
| ${stacktrace}         | 呼叫堆疊資訊                           |      |
| ${threadid}           |                                        | 必填 |
| ${time}               | 時間格式，HH:mm:ss.mmm.                |      |
| ${windows-            | identity}	登入帳號                     |      |
| ${buildConfiguration} | 組態檔名                               |      |

參考範本

> \${date}|${level:uppercase=true}|${logger}|${message} ${exception}|${all-event-properties}

執行結果

> 2017/12/15 09:51:21.867|INFO|NLogPractice.RunnerToFile|3 |
