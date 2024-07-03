# csv

CsvLayout

範例

```json
  "NLog": {
    "autoReload": true,
    "internalLogLevel": "Debug",
    "internalLogFile": "${basedir}/Log/internal-nlog-AspNetCore.txt",
    "extensions": [
      {
        "assembly": "NLog.Web.AspNetCore"
      }
    ],
    "targets": {
      "allCsvFile": {
        "type": "File",
        "fileName": "${basedir}/Log/nlog-AspNetCore-all-${shortdate}.csv",
        "encoding": "utf-8",
        "maxArchiveDays": 7,
        "archiveFileName": "${basedir}/Log/Archive/nlog-AspNetCore-all-${shortdate}.{#}.csv",
        "archiveEvery": "Day",
        "createDirs": true,
        "layout": {
          "type": "CsvLayout",
          "delimiter": "Comma",
          "withHeader": true,
          "columns": [
            {
              "name": "datetime",
              "layout": "${date}"
            },
            {
              "name": "event",
              "layout": "${event-properties:item=EventId:whenEmpty=0}"
            },
            {
              "name": "threadid",
              "layout": "${threadid}"
            },
            {
              "name": "connectionid",
              "layout": "${aspnet-request-connection-id}"
            },
            {
              "name": "level",
              "layout": "${level:upperCase=true}"
            },
            {
              "name": "logger",
              "layout": "${logger}"
            },
            {
              "name": "message",
              "layout": "${message}"
            },
            {
              "name": "exception",
              "layout": "${exception:format=tostring}"
            }
          ]
        }
      }
    },
    "rules": [
      {
        "logger": "*",
        "minLevel": "Debug",
        "writeTo": "allCsvFile"
      }
    ]
  },
```
