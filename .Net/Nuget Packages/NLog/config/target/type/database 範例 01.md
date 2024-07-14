# database 範例 01

參考資料：

-   [Getting started with ASP.NET Core 6](https://github.com/NLog/NLog/wiki/Getting-started-with-ASP.NET-Core-6)

---

步驟：

-   建立專案

-   安裝套件

    ```
    dotnet add package NLog.Web.AspNetCore
    dotnet add package NLog.Database
    dotnet add package Microsoft.Data.SqlClient
    ```

-   設定 NLog.config

    ```xml
    <?xml version="1.0" encoding="utf-8"?>

    <nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        autoReload="true"
        internalLogLevel="Info"
        internalLogFile="Log/internal-nlog-AspNetCore.txt">

        <!-- enable asp.net core layout renderers -->
        <extensions>
            <add assembly="NLog.Web.AspNetCore" />
        </extensions>

        <!-- the targets to write to -->
        <targets>
            <!-- File Target for all log messages with basic details -->
            <target xsi:type="File" name="allfile" fileName="Log/nlog-AspNetCore-all-${shortdate}.log"
                    layout="${longdate}|${event-properties:item=EventId:whenEmpty=0}|${level:uppercase=true}|${logger}|${message} ${exception:format=tostring}" />

            <!-- File Target for own log messages with extra web details using some ASP.NET core renderers -->
            <target xsi:type="File" name="ownFile-web" fileName="Log/nlog-AspNetCore-own-${shortdate}.log"
                    layout="${longdate}|${event-properties:item=EventId:whenEmpty=0}|${level:uppercase=true}|${logger}|${message} ${exception:format=tostring}|url: ${aspnet-request-url}|action: ${aspnet-mvc-action}" />

            <!--Console Target for hosting lifetime messages to improve Docker / Visual Studio startup detection -->
            <target xsi:type="Console" name="lifetimeConsole" layout="${MicrosoftConsoleLayout}" />

            <!-- Database Target for all log messages -->
            <target xsi:type="Database" name="writeToDb">
                <connectionString>
                    Server=10.211.55.3,1433;Database=TestNLogDB;User Id=sa;Password=YourStrong@Passw0rd;trusted_connection=false;trusted_connection=false;Encrypt=True;TrustServerCertificate=True;
                </connectionString>
                <commandText>
                    INSERT INTO [dbo].[Log] ([MachineName],
                                            [Logged],
                                            [Level],
                                            [Message],
                                            [Logger],
                                            [Exception])
                    VALUES (@MachineName,
                            @Logged,
                            @Level,
                            @Message,
                            @Logger,
                            @Exception);
                </commandText>

                <parameter name="@MachineName" layout="${machinename}" />
                <parameter name="@Logged" layout="${date}" />
                <parameter name="@Level" layout="${level}" />
                <parameter name="@Message" layout="${message}" />
                <parameter name="@Logger" layout="${logger}" />
                <parameter name="@Exception" layout="${exception:format=ToString}" />

            </target>
        </targets>

        <!-- rules to map from logger name to target -->
        <rules>
            <!--All logs, including from Microsoft-->
            <logger name="*" minlevel="Trace" writeTo="allfile" />

            <!--Output hosting lifetime messages to console target for faster startup detection -->
            <logger name="Microsoft.Hosting.Lifetime" minlevel="Info" writeTo="lifetimeConsole, ownFile-web" final="true" />

            <!--Skip non-critical Microsoft logs and so log only own logs (BlackHole) -->
            <logger name="Microsoft.*" maxlevel="Info" final="true" />
            <logger name="System.Net.Http.*" maxlevel="Info" final="true" />

            <logger name="*" minlevel="Trace" writeTo="ownFile-web" />
            <logger name="*" minlevel="Trace" writeTo="writeToDb" />
        </rules>
    </nlog>
    ```

-   設定 Program.cs

-   安裝套件

    ```
    dotnet add package NLog.Database
    dotnet add package Microsoft.Data.SqlClient
    ```

-   建立 DB

    ```
    Server=10.211.55.3,1433;Database=TestNLogDB;User Id=sa;Password=YourStrong@Passw0rd;
    ```

    ```sql
    CREATE DATABASE [TestNLogDB];
    GO;

    USE [TestNLogDB];
    GO;

    CREATE TABLE [Log]
    (
        [Id]           int IDENTITY
            CONSTRAINT [Log_pk]
                PRIMARY KEY,
        [MachineName]  nvarchar(50)  NOT NULL,
        [DateTime]     datetime2     NOT NULL,
        [Event]        NVARCHAR(50)  NOT NULL,
        [Level]        NVARCHAR(50)  NOT NULL,
        [ThreadId]     NVARCHAR(50)  NOT NULL,
        [ConnectionId] NVARCHAR(50)  NOT NULL,
        [Logger]       NVARCHAR(250) NOT NULL,
        [Message]      NVARCHAR(max) NOT NULL,
        [Exception]    NVARCHAR(max) NOT NULL
    )
    GO;
    ```
