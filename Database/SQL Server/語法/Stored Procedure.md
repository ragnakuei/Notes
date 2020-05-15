# Stored Procedure

```sql
USE [Northwind]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 可用於各版本 SQL Server，但可能會抓錯不同 schema 
-- IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'usp_Test')
-- DROP PROCEDURE [dbo].[usp_Test];
-- GO

-- SQL Server 2016 後才支援的語法
DROP PROCEDURE IF EXISTS [dbo].[usp_Test];  
GO

CREATE PROCEDURE [dbo].[usp_Test]
    @Id varchar(10)
AS
    SELECT @Id as Id;
GO
```