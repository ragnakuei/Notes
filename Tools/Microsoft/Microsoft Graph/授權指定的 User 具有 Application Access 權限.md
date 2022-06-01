# 授權指定的 User 具有 Application Access 權限

- 授權後，才可以存取需要 Application Access 權限的 API。
- 已知的 API
  - OnlineMeeting

## [Install Microsoft Teams PowerShell Module](https://docs.microsoft.com/en-us/microsoftteams/teams-powershell-install)

- 以系統管理員身份執行

  ```
  Install-Module -Name PowerShellGet -Force -AllowClobber
  Install-Module -Name MicrosoftTeams -Force -AllowClobber
  ```

- 輸入以下 cmd 以登入 Microsoft Teams

  ```
  Connect-MicrosoftTeams
  ```

- 更新 Module

  ```
  Update-Module MicrosoftTeams
  ```

## [Allow applications to access online meetings on behalf of a user](https://docs.microsoft.com/en-us/graph/cloud-communication-online-meeting-application-access-policy)

- 執行以下指令
  - AppIds 後方可接多個 ID，用 , 間隔即可 !

  ```
  New-CsApplicationAccessPolicy -Identity MicrosoftTeamsApiTest-policy -AppIds "AppID" -Description "For-Test-Only-Description"
  ```

  - 成功執行之結果

    ```
    Identity    : Tag:MicrosoftTeamsApiTest-policy
    AppIds      : {AppID}
    Description : For-Test-Only-Description
    ```

- 執行以下指令 
  - Identity 後方為指定的 UserID

  ```
  Grant-CsApplicationAccessPolicy -PolicyName MicrosoftTeamsApiTest-policy -Identity "UserID"
  ```

  - 成功執行後不會有訊息

- 授權成功 !