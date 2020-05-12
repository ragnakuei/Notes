# logger 設定 rule 1

以下 rules 的設定，可參考:[rules](../rules.md)

NLog.config 重點設定如下：

```xml
<targets>
  <target xsi:type="File" name="controllers" fileName="${basedir}/logs/${shortdate}-Controllers.log"
          layout="${longdate} ${uppercase:${level}} ${logger} ${message}" />
  <target xsi:type="File" name="extends" fileName="${basedir}/logs/${shortdate}-Extends.log"
          layout="${longdate} ${uppercase:${level}} ${logger} ${message}" />
  <target xsi:type="File" name="all" fileName="${basedir}/logs/${shortdate}-All.log"
          layout="${longdate} ${uppercase:${level}} ${logger} ${message}" />
</targets>

<rules>
  <logger name="nlogPractice01.Controllers.*" minlevel="Info" writeTo="controllers" />
  <logger name="nlogPractice01.Extends.*" levels="Warn,Error" writeTo="extends" />
  <logger name="*" minlevel="Debug" writeTo="all" />
</rules>
```

各 log 內容如下：

2017-06-01-Controllers.log
    
- rules 設定為 
  - 記錄 Info 以上的 log level 
  - 記錄 nlogPractice01.Controllers 的所有 class
- 所以不會記錄到 Debug，也不會記錄到非 Controller 的 log

```log
2017-06-01 10:17:43.9691 INFO nlogPractice01.Controllers.HomeController 我是Info
2017-06-01 10:17:43.9841 WARN nlogPractice01.Controllers.HomeController 我是Warn
2017-06-01 10:17:43.9841 ERROR nlogPractice01.Controllers.HomeController 我是Error
2017-06-01 10:17:43.9971 FATAL nlogPractice01.Controllers.HomeController 我是Fatal
```

2017-06-01-Extends.log
- rules 設定為
  - 記錄 Warn & Error 的 log level 
  - 記錄 nlogPractice01.Extends 的所有 class

```log
2017-06-01 10:17:43.9491 WARN nlogPractice01.Extends.Extensions 我是Warn
2017-06-01 10:17:43.9491 ERROR nlogPractice01.Extends.Extensions 我是Error
```

2017-06-01-All.log
- rules 設定為
  - 記錄 Info 以上的 log level
  - 記錄所有 class

```log
2017-06-01 10:17:43.9301 DEBUG nlogPractice01.Extends.Extensions 我是Debug
2017-06-01 10:17:43.9491 INFO nlogPractice01.Extends.Extensions 我是Info
2017-06-01 10:17:43.9491 WARN nlogPractice01.Extends.Extensions 我是Warn
2017-06-01 10:17:43.9491 ERROR nlogPractice01.Extends.Extensions 我是Error
2017-06-01 10:17:43.9691 FATAL nlogPractice01.Extends.Extensions 我是Fatal
2017-06-01 10:17:43.9691 DEBUG nlogPractice01.Controllers.HomeController 我是Debug
2017-06-01 10:17:43.9691 INFO nlogPractice01.Controllers.HomeController 我是Info
2017-06-01 10:17:43.9841 WARN nlogPractice01.Controllers.HomeController 我是Warn
2017-06-01 10:17:43.9841 ERROR nlogPractice01.Controllers.HomeController 我是Error
2017-06-01 10:17:43.9971 FATAL nlogPractice01.Controllers.HomeController 我是Fatal
```