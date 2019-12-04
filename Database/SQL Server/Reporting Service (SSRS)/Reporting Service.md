# Reproting Service

## 環境

- [SQL Server Reporting Services](https://docs.microsoft.com/zh-tw/sql/reporting-services/install-windows/install-reporting-services)

  - 安裝 SQL Server Reporting Services - 可選擇`開發人員 Edition`
  - Default Reporting Server Instance - `SSRS`
  - 安裝完畢後，會開啟 [Report Server Configuration Manager]

    - 每一步驟設定完畢後，要按下`套用`
    - Web 服務 URL > 按下`套用`後，開啟 URL > 等待約一、二分鐘後，會顯示 SSRS 版本，此頁面不要關閉，等下要輸入 URL
    - 資料庫 > 𠨫更資料庫 > 第一次可用 `新增報表伺服器資料庫`
    - 資料庫 > 資料庫伺服器 > 伺服器名稱，輸入 `.\mssql2017`
    - 測試連接 通過

- [Microsoft® Report Builder](https://www.microsoft.com/en-us/download/details.aspx?id=53613)

  - 安裝 `Microsoft® Report Builder`
  - Default Target Server > 輸入上面未關閉的 `SSRS Web 服務 URL`

- [SQL Server Data Tools](https://docs.microsoft.com/zh-tw/sql/ssdt/download-sql-server-data-tools-ssdt) (SSDT)

  - Visual Studio 2017 要安裝 SQL Server Data Tools
  - Visual Studio 2019 - 透過 Visual Studio Installer 安裝

    - 安裝完畢後，建立新專案時，可選擇`報表伺服器專案`及`報表伺服器專案精靈`
    - 可能的替代做法 - 透過 Visual Studio Market 安裝 [Microsoft Reporting Service Projects](https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio)

---

## 教學

- 非官方

  - [影片](https://www.youtube.com/playlist?list=PL7A29088C98E92D5F)
  - [SSRS Tutorials](http://ssrstutorials.blogspot.com/2012/07/ssrs-tutorials.html)

- 官方

  - [第 1 課：建立報表伺服器專案 (Reporting Services)](https://docs.microsoft.com/zh-tw/sql/reporting-services/lesson-1-creating-a-report-server-project-reporting-services)
  - [第 2 課：指定連接資訊 (Reporting Services)](https://docs.microsoft.com/zh-tw/sql/reporting-services/lesson-2-specifying-connection-information-reporting-services)
  - [第 3 課：定義資料表報表的資料集 (Reporting Services)](https://docs.microsoft.com/zh-tw/sql/reporting-services/lesson-3-defining-a-dataset-for-the-table-report-reporting-services)
  - [第 4 課：將資料表加入至報表 (Reporting Services)](https://docs.microsoft.com/zh-tw/sql/reporting-services/lesson-4-adding-a-table-to-the-report-reporting-services)
  - [第 5 課：格式化報表 (Reporting Services)](https://docs.microsoft.com/zh-tw/sql/reporting-services/lesson-5-formatting-a-report-reporting-services)
  - [第 6 課：新增群組和總計 (Reporting Services)](https://docs.microsoft.com/zh-tw/sql/reporting-services/lesson-5-formatting-a-report-reporting-services)

---

## 報表伺服器專案

- 每個 .rdl 都是一個報表
- 每個報表都會有自己的`連線字串`跟`資料夾`，簡單來說，就是`報表資料`這邊的 panel 內的各個項目，都是每個報表各自獨立的。
- 新增報表的順序： 新增 .rdl > 新增資料來源 > 新增資料集 > 設計報表
- 文字方塊屬性 > 數字 - 其實是設定`文字格式`
- Header 的部份，可用反白選取後，直接點下`工具列`的文字屬性

  - 如果用文字方塊屬性，就會套用整個儲存格格式

- 總計

  - 新增時，以`資料列群組`最小群組單位為主

  - 如果有二個服上`資料列群組`欄位，可新增二個`總計`欄位後，再至`資料列群組` > `群組屬性` > `一般` 來調整`群組對象`

- 報表發佈至報表伺服器

  - Target Report Server 的設定在：專案屬性 > 一般 > `TargetServerURL`
  - URL 結構 `TargetServerURL`/Pages/ReportViewer.aspx?/`TargetReportFolder`/`報表名稱主檔名`&rs:ClearSession=true&rc:View=7883bff4-e242-4763-9cf5-2e1fae84c54f

---

## Report Sever

- 會放至 Root Folder 的項目
  - 共用資料來源
  - 各 `TargetReportFolder`
