# Connection String 範例

## providerName 為 SqlClient

```xml
<add name="Model1" 
     connectionString="data source=.\mssql2017;initial catalog=Northwind;integrated security=True;MultipleActiveResultSets=True;App=EntityFramework"
     providerName="System.Data.SqlClient" />

<add name="AuthorizePracticeByRole"
     connectionString="data source=.\MSSQL2017;initial catalog=AuthorizePracticeByRole;persist security info=True;integrated security=True;"
     providerName="System.Data.SqlClient" />
```


## providerName 為 EntityClient

```xml
<add name="NorthwindEntities" 
    connectionString="metadata=res://*/ef.Model2.csdl|res://*/ef.Model2.ssdl|res://*/ef.Model2.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=.\mssql2017;initial catalog=Northwind;integrated security=True;multipleactiveresultsets=True;application name=EntityFramework&quot;" 
    providerName="System.Data.EntityClient" />
```

