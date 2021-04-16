# 建立 Nuget Package

- 建立程式碼
- 以 Visual Studio 開啟 Project
- Project Properties > Package
  - 輸入 metadata
    - 勾選 Generate Nuget package on build
    - 輸入 Package id
    - 輸入 Package version - 此項在 Visual Studio 2019 16.9.3 不會正常套用
    - 輸入 Authors
    - 輸入 Company
    - 輸入 Product
    - 輸入 Project Url
    - 輸入 Respsitory Url

- 上傳 Nuget Package (.nupkg)
  - [Upload](https://www.nuget.org/packages/manage/upload)
  - 透過 NuGetPackageExplorer 
    - 部份 metadata 無法套用