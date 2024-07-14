# file

參考資料

-   [File target](https://github.com/NLog/NLog/wiki/File-target)

包含了

-   Pure Text
-   [Json](./Json.md)
-   [CSV](./CSV.md)

相關的 attribiutes

-   fileName
    此項 target 檔案存放路徑

## [Archival Options](https://github.com/NLog/NLog/wiki/File-target#archival-options)

範例

```xml
<target
    xsi:type="File"
    name="allfile"
    fileName="${basedir}/Logs/nlog-AspNetCore-all-${shortdate}.log"
    layout="${longdate} | ${event-properties:item=EventId:whenEmpty=0} | ${level:uppercase=true} | ${aspnet-request-connection-id} | ${logger} | ${message} ${exception:format=tostring} | requestBody: ${aspnet-request-posted-body} "
    archiveFileName="Log/archives/nlog-AspNetCore-all.{#####}.txt"
    archiveAboveSize="5000000"
    archiveEvery="Day"
    archiveNumbering="Rolling"
    maxArchiveFiles="3"
/>
```
