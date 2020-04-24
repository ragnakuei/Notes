# Sample01

## Web.config

```xml
<configuration>
   <system.web>
      <httpHandlers>
         <add verb="*" path="handler.aspx" type="HandlerExample.MyHttpHandler,HandlerTest"/>
      </httpHandlers>
   </system.web>
</configuration>
```