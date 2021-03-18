# 建立 create database migration 的方式

不管目前 db 設計到哪個階段，如果需要只有建立 db 的 migration，而不包含 table 的資料

就把 migration.cs 的 Up() 跟 Down() 全部刪除後，直接進行 migration 就可以了 !
