# logger 設定 rule 2

```xml
<?xml version="1.0" encoding="utf-8" ?>
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.nlog-project.org/schemas/NLog.xsd"
      autoReload="true"
      throwExceptions="false"
      internalLogLevel="Off" internalLogFile="c:\temp\nlog-internal.log">

  <!-- optional, add some variables
  https://github.com/nlog/NLog/wiki/Configuration-file#variables
  -->
  <variable name="logPath" value="${basedir}"/>

  <!--
  See https://github.com/nlog/nlog/wiki/Configuration-file
  for information on customizing logging rules and outputs.c
   -->
  <targets>

    <!--
    add your targets here
    See https://github.com/nlog/NLog/wiki/Targets for possible targets.
    See https://github.com/nlog/NLog/wiki/Layout-Renderers for the possible layout renderers.
    -->

    <!--
    Write events to a file with the date in the filename.
    -->    
    <target xsi:type="File" name="f" fileName="${logPath}/logs/webapi/${shortdate}.log"
            layout="${longdate} ${uppercase:${level}} ${message}"
            encoding="utf-8" />
    
    <target xsi:type="File" name="Sns" fileName="${logPath}/logs/webapi/Sns ${shortdate}.log"
            layout="${longdate} ${uppercase:${level}}-${activityid}-${message}"
            encoding="utf-8" />

  </targets>

  <rules>
    <!-- add your logging rules here -->

    <!--
    Write all events with minimal level of Debug (So Debug, Info, Warn, Error and Fatal, but not Trace)  to "f"
    -->    
    <logger name="*" minlevel="Info" writeTo="f" />
    
    <logger name="WebAPI.Controllers.PortraitController" minlevel="Debug" writeTo="Sns" />
    <logger name="WebAPI.Controllers.UpdateController" minlevel="Debug" writeTo="Sns" />
    <logger name="Data.Services.DeviceService" minlevel="Debug" writeTo="Sns" />
    <logger name="Data.Services.SubscriptionWebService" minlevel="Debug" writeTo="Sns" />
    <logger name="Data.Services.SnsWebService" minlevel="Debug" writeTo="Sns" />
    <logger name="Data.Models.UpdateDto" minlevel="Debug" writeTo="Sns" />
    <logger name="Data.Repositoies.Device" minlevel="Debug" writeTo="Sns" />
    
  </rules>
</nlog>
```