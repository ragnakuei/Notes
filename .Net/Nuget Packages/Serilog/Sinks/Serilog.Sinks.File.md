# [Serilog.Sinks.File](https://github.com/serilog/serilog-sinks-file/blob/master/src/Serilog.Sinks.File/FileLoggerConfigurationExtensions.cs)

## args

### path

檔案路徑

### restrictedToMinimumLevel

最小的 Log Level

### outputTemplate

Log 輸出內容範本

預設是 `{Timestamp:yyyy-MM-dd HH:mm:ss.fff zzz} [{Level:u3}] {Message:lj}{NewLine}{Exception}`

### formatProvider

### fileSizeLimitBytes

-   檔案最大容量
-   預設 1 GB

### levelSwitch

### buffered

### shared

### flushToDiskInterval

### rollingInterval

-   預設 RollingInterval.Infinite
-   還可指定 年、月、日、時、分

### rollOnFileSizeLimit

-   預設 false
-   當目前寫入的 Log 檔達到 fileSizeLimitBytes 所指定大小後，是否要進行 roll 的動作

### retainedFileCountLimit

-   預設 31
-   roll 之後，所保留的 Log 檔案數量

### encoding

### hooks
