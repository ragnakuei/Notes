# logrotate 範例

參數設定可參考：[target](../target.md)

## 範例一

```csharp
archiveFileName="${basedir}/archives/log.{#####}.txt"
archiveAboveSize="5000000"  // will move file to archive once it reaches this size
archiveEvery="Day" // will move file to archive at the top of the day
archiveNumbering = "Sequence" (or "Rolling" if you prefer)
maxArchiveFiles="3" // number of archive files to keep
```

## [範例二](http://www.danesparza.net/2014/06/things-your-dad-never-told-you-about-nlog/)
## [範例三](https://stackoverflow.com/questions/3000653/using-nlog-as-a-rollover-file-logger)
