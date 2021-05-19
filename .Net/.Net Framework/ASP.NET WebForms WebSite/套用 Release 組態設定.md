# 套用 Release 組態設定

-   發佈檔
    -   建議只建立以 Release 方案組態 為主的發佈設定檔
        -   實際上無 Release 專案組態 !!

## 範例一

-   建立 Webform WebSite 專案
-   組態管理員
    -   新增 Release 方案組態
        -   實際上，編譯時，不會有 Release 專案組態
        -   只是為了給 Web.Release.config 套用
-   精簡專案
    -   刪除 Account 資料夾
    -   刪除 App_Code 內的 AuthConfig.cs 及 RouteConfig.cs
    -   刪除 Content 資料夾
    -   刪除 Images 資料夾
    -   刪除 Scripts 資料夾
    -   刪除 About / Contact 等 aspx 及 aspx.cs 檔
    -   刪除 packages.config 檔
    -   刪除 Site.master / Site.master.cs
    -   刪除 Site.Mobile.master / Site.Mobile.master.cs
    -   刪除 ViewSwitch.ascx / ViewSwitch.ascx.cs
    -   刪除 Default.aspx 的 Content 內容
    -   把 Web.Debug.config 改為 Web.Release.config

-   Web.config 調整

    -   設定完畢後
        -   可在 Visual Studio > Web.Release.config 上面，按下滑鼠右鍵，選擇 `預覽和轉換` 來檢視 web.config 是否會符合預期 !


    -   Web.config

        本機執行用

        ```xml
        <?xml version="1.0" encoding="UTF-8"?>

        <configuration>
            <appSettings>
                <add key="DEBUG" value="false"/>
            </appSettings>

            <connectionStrings>
                <add name="Default"
                     connectionString="Data Source=.\mssql2017 ;Initial Catalog=xxxx ;Trusted_Connection=True;MultipleActiveResultSets=true"
                     providerName="System.Data.SqlClient" />
            </connectionStrings>

            <system.web>
                <customErrors mode="Off" />
                <compilation debug="true" targetFramework="4.0" />
            </system.web>

        </configuration>
        ```

    -   Web.Release.config

        發佈至正式機用

        ```xml
        <?xml version="1.0" encoding="utf-8"?>

        <configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
            <appSettings>
                <add key="DEBUG" value="false"
                    xdt:Transform="SetAttributes" xdt:Locator="Match(key)" />

                <add key="DEBUG.ACCOUNT"
                    xdt:Transform="Remove" xdt:Locator="Match(key)" />
            </appSettings>

            <connectionStrings>
                <add name="Default"
                    connectionString="Data Source=xxxx,4300;Initial Catalog=xxxx ;User ID=xxxx;Password=xxxx;Trusted_Connection=false;"
                    providerName="System.Data.SqlClient"
                    xdt:Transform="SetAttributes" xdt:Locator="Match(name)"/>
            </connectionStrings>

            <system.web>
                <compilation xdt:Transform="RemoveAttributes(debug)" />
            </system.web>
        </configuration>
        ```

-   建立發佈設定

    -   在專案上面按下滑鼠右鍵，選擇 `發佈 Web 應用程式`
    -   選擇 `發佈至資料夾`
    -   檔案會建立在 /App_Data/PublishProfiles/ 資料夾中
    -   目標位置設定在 Publish\
    -   組態選擇 Release
        -   這裡指的是方案組態
        -   會同步讀取 Web.config 及 Web.Release.config 來產生最後的 Web.config
    -   更改發佈檔檔名
        -   因為 Visual Studio 無法改變發佈名稱，所以要先儲存，再手動調整
        -   至 /App_Data/PublishProfiles/ 資料夾中，找到剛才建立的發佈
        -   將檔名改為 Release.pubxml

-   發佈專案

    -   因為實際上無 Release 方案組態設定，所以發佈只針對 Release 方案組態發佈
    -   Debug 的方案組態就只視為本機開發用

### 如果想要拆成多個方案組態設定

也是可以，但需要注意一下動作

-   建議把發佈資料夾統一指定至 publish 資料夾內
    -   Debug 發佈至 publish/Debug 中
    -   Release 發佈至 publish/Release 中
-   每次發佈時，就要把其他組態的發佈資料夾清空
    -   否則發佈時的編譯就會失敗
    -   初步猜測跟專案只有 Debug 專案組態有關 !
