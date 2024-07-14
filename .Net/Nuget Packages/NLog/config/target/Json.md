# Json

參考資料

-   https://github.com/NLog/NLog/wiki/JsonLayout

比起純文字，有更好的結構 !

```xml
<target xsi:type="File"
        name="allJsonFile"
        fileName="${basedir}\Logs\nlog-AspNetCore-all-${shortdate}.log.json"
        encoding="utf-8"
        maxArchiveDays="7"
        archiveFileName="${basedir}\Logs\Archive\nlog-AspNetCore-all-${shortdate}.{#}.log.json"
        archiveEvery="Day"
        createDirs="true"
>
    <layout xsi:type="JsonLayout">
        <attribute name="datetime" layout="${date}" />
        <attribute name="event" layout="${event-properties:item=EventId:whenEmpty=0}"/>
        <attribute name="level" layout="${level:upperCase=true}"/>
        <attribute name="threadid" layout="${threadid}"/>
        <attribute name="connectionid" layout="${aspnet-request-connection-id}"/>
        <attribute name="logger" layout="${logger}"/>
        <attribute name="message" layout="${message}"/>
        <attribute name="exception" layout="${exception:format=tostring}"/>
    </layout>
</target>
```

輸出結果

```json
{ "datetime": "2023/11/20 14:15:08.844", "event": "49", "threadid": "14", "connectionid": " ", "level": "TRACE", "logger": "Microsoft.AspNetCore.Server.Kestrel.Http2", "message": "Connection id \"0HMV9I05EMNHV\" sending HEADERS frame for stream ID 7 with length 34 and flags END_HEADERS.", "logger": "Microsoft.AspNetCore.Server.Kestrel.Http2" }
{ "datetime": "2023/11/20 14:15:08.844", "event": "49", "threadid": "14", "connectionid": " ", "level": "TRACE", "logger": "Microsoft.AspNetCore.Server.Kestrel.Http2", "message": "Connection id \"0HMV9I05EMNHV\" sending DATA frame for stream ID 7 with length 4541 and flags NONE.", "logger": "Microsoft.AspNetCore.Server.Kestrel.Http2" }
{ "datetime": "2023/11/20 14:15:08.844", "event": "2", "threadid": "14", "connectionid": "0HMV9I05EMNHV ", "level": "INFO", "logger": "Microsoft.AspNetCore.Hosting.Diagnostics", "message": "Request finished HTTP/2 GET https://localhost:7088/swagger/v1/swagger.json - - - 200 - application/json;charset=utf-8 4.4301ms", "logger": "Microsoft.AspNetCore.Hosting.Diagnostics" }
{ "datetime": "2023/11/20 14:15:08.844", "event": "49", "threadid": "11", "connectionid": " ", "level": "TRACE", "logger": "Microsoft.AspNetCore.Server.Kestrel.Http2", "message": "Connection id \"0HMV9I05EMNHV\" sending DATA frame for stream ID 7 with length 0 and flags END_STREAM.", "logger": "Microsoft.AspNetCore.Server.Kestrel.Http2" }
```
