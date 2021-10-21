# [錯誤示範]阻擋同時 Insert

原因
> 幾乎同時寫入仍然可以打穿 !
> 目前以 Parallel.For(1, 4, () => {}) 額外打穿二筆 (就是同時寫入三筆...) !

```sql
INSERT INTO [dbo].[Booking]([Guid],
                            [BookerGuid],
                            [Title],
                            [MeetingRoomGuid],
                            [BeginDate],
                            [BeginTime],
                            [EndDate],
                            [EndTime],
                            [Remark],
                            [CreateTime],
                            [CreatorGuid],
                            [DataStatusId])
SELECT @Guid,
       @BookerGuid,
       @Title,
       @MeetingRoomGuid,
       @BeginDate,
       @BeginTime,
       @EndDate,
       @EndTime,
       @Remark,
       @CreateTime,
       @CreatorGuid,
       @ActiveDataStatusId
WHERE NOT EXISTS(
        SELECT 1
        FROM [dbo].[Booking] [b]
        WHERE [b].[MeetingRoomGuid] = @MeetingRoomGuid
          AND [b].[BeginDate] = @BeginDate
          AND [b].[EndDate] = @EndDate
          AND NOT (
                ([b].[EndTime] <= @BeginTime) 
             OR ([b].[BeginTime] >= @EndTime)
          )
    )
```