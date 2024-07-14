# CSV

參考資料

-   https://github.com/NLog/NLog/wiki/CsvLayout

比起純文字，有更好的結構 !

注意事項：

-   2023/11/20 ： delimiter 用 Comma 比 Tab 格式更正確 !

```xml
<target xsi:type="File"
        name="allCsvFile"
        fileName="${basedir}\Logs\nlog-AspNetCore-all-${shortdate}.log.csv"
        encoding="utf-8"
        maxArchiveDays="7"
        archiveFileName="${basedir}\Logs\Archive\nlog-AspNetCore-all-${shortdate}.{#}.log.csv"
        archiveEvery="Day"
        createDirs="true"
        >
    <layout xsi:type="CsvLayout" delimiter="Comma" withHeader="true">
        <column name="datetime" layout="${date}" quoting="All" />
        <column name="event" layout="${event-properties:item=EventId:whenEmpty=0}" quoting="All" />
        <column name="level" layout="${level:upperCase=true}" quoting="All" />
        <column name="threadid" layout="${threadid}"/>
        <column name="connectionid" layout="${aspnet-request-connection-id} "/>
        <column name="logger" layout="${logger}" quoting="All" />
        <column name="message" layout="${message}" quoting="All" />
        <column name="exception" layout="${exception:format=tostring}" quoting="All" />
    </layout>
</target>
```

輸出結果

```csv
"2023/11/20 14:15:08.844","49",14, ,"TRACE","Microsoft.AspNetCore.Server.Kestrel.Http2","Connection id ""0HMV9I05EMNHV"" sending HEADERS frame for stream ID 7 with length 34 and flags END_HEADERS.","Microsoft.AspNetCore.Server.Kestrel.Http2"
"2023/11/20 14:15:08.844","49",14, ,"TRACE","Microsoft.AspNetCore.Server.Kestrel.Http2","Connection id ""0HMV9I05EMNHV"" sending DATA frame for stream ID 7 with length 4541 and flags NONE.","Microsoft.AspNetCore.Server.Kestrel.Http2"
"2023/11/20 14:15:08.844","2",14,0HMV9I05EMNHV ,"INFO","Microsoft.AspNetCore.Hosting.Diagnostics","Request finished HTTP/2 GET https://localhost:7088/swagger/v1/swagger.json - - - 200 - application/json;charset=utf-8 4.4301ms","Microsoft.AspNetCore.Hosting.Diagnostics"
"2023/11/20 14:15:08.844","49",11, ,"TRACE","Microsoft.AspNetCore.Server.Kestrel.Http2","Connection id ""0HMV9I05EMNHV"" sending DATA frame for stream ID 7 with length 0 and flags END_STREAM.","Microsoft.AspNetCore.Server.Kestrel.Http2"
```
