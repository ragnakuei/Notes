# [Serilog.Sinks.MSSqlServer](https://github.com/serilog/serilog-sinks-mssqlserver)

## Args 設定

### connectionString

-   指定連線字串

### sinkOptionsSection

-   schemaName
-   tableName
-   autoCreateSqlTable
-   batchPostingLimit
-   period
-   useAzureManagedIdentity
-   azureServiceTokenProviderResource

### restrictedToMinimumLevel

- 最小的 Log Level

### columnOptionsSection

-   primaryKeyColumnName

-   disableTriggers

-   clusteredColumnstoreIndex

-   addStandardColumns

    -   指定預設未加入的 Standard Column

-   removeStandardColumns

    -   指定要移除的 `Standard Columns`

-   additionalColumns

    -   指定要額外增加的 `Column`

-   Standard Columns

    -   會以 Standard Column 做為 Section Name
    -   columnName
        指定為其他的 Column Name

        ```json
        "message": {
            "columnName": "Msg"
        },
        "exception": {
            "columnName": "Ex"
        },
        "messageTemplate": {
            "columnName": "Template"
        }
        ```

    - propertyName
      
      template 所指定的名稱
      
      通常用於 template 名稱要與 column name 不相同的時候。

### logEventFormatter