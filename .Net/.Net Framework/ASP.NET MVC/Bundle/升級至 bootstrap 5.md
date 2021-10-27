# 升級至 bootstrap 5

BundleConfig.cs
- 透過 nuget 將 bootstrap 升級到 bootstrap v5
- 把

  ```cs
  bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include("~/Scripts/bootstrap.js"));
  ```

  改為

  ```cs
  bundles.Add(new Bundle("~/bundles/bootstrap").Include("~/Scripts/bootstrap.js"));
  ```
