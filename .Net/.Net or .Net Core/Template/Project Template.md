# Project Tempalte

### 建立本地端[專案範本](https://learn.microsoft.com/en-us/dotnet/core/tutorials/cli-templates-create-project-template)

1. 從專案範本建立專案 ( 以下假設用 Console 來建立 )
1. 加上自己需要的修改
1. 加上 template.config\template.json

    ```json
    {
        "$schema": "http://json.schemastore.org/template",
        "author": "Kuei",
        "classifications": ["Console"],
        "identity": "Kuei.ProjectTempalteName.Identity",
        "name": "Kuei.ProjectTempalteName.Name",
        "shortName": "Kuei.ShortName",
        "tags": {
            "language": "C#",
            "type": "project"
        }
    }
    ```

1. 安裝範本

    這會綁住專案範本的路徑，所以如果專案範本有修改，就要重新安裝一次

    > dotnet new install <專案範本路徑>

1. 檢查範本是否安裝成功

    > dotnet new list

1. 使用範本建立專案

    > dotnet new <專案範本名稱> -n <專案名稱>

1. 移除範本

    可以先用下面的指令，來檢查是否有安裝成功，同時會列出移除的指令

    > dotnet new list

    移除範本

    > dotnet new uninstall <專案範本完整路徑>
