# OAuth 2 credentail 申請

## Google Calendar API

### OAuth 2 credentail 申請範例一

1. 開啟 https://developers.google.com/calendar/quickstart/dotnet?authuser=2

1. 點 `Enable Google Calendar API`
1. 設定 `OAuth Client`
1. Client 的類型有多個，選擇 `Web browser`
1. 輸入 `Authorized Javascript Origin`
1. 按下建立
1. 建立完畢後，點擊 `Download Client Configuration` 下載 `credentials.json`

### OAuth 2 credentail 申請範例二

1. 到 [這裡](https://console.developers.google.com/cloud-resource-manager) 建立 Project
1. 至 [Library](https://console.developers.google.com/apis/library) 輸入關鍵字 `Google Calendar API` 並點擊該 API Icon
1. 點擊 `Enable`
1. 到 [Credentails](https://console.developers.google.com/apis/credentials)
1. 點擊 Create Credentials
1. 選擇 OAuth client ID
    1. `Application Type` 依照情況選擇，如果是 asp.net 後端呼叫，就選擇 `Web Application`
    2. `Authorized JavaScript origins` 填上要執行的 domain，例：`http://localhost`
    3. `Authorized redirect URIs` 填上要執行的 domain 再加上 authorize，例：`https://localhost/authorize/`
        - 不用管 port
1. 按下 `Save` 下載 `credential.json`
1. `credential.json` 給程式用來判斷是屬於該 project 的
1. 到 [OAuth consent screen](https://console.developers.google.com/apis/credentials/consent), 點擊 `EDIT APP`
1. `Scopes for Google APIs` 加上 Google Calendar API 所需要的 Scope
    1. ../auth/calendar.events
    2. ../auth/calendar.readonly
    3. ../auth/calendar.events.readonly
    4. ../auth/calendar
1. 按下 `Save`
