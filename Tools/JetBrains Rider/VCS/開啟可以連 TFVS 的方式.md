# 開啟可以連 TFVS 的方式

- 至[這裡](https://github.com/Microsoft/team-explorer-everywhere/releases)下載 `TEE-CLC-XX.XXX.X.zip`

- 解壓至到指定資料夾

- 開啟 Rider

  - Go to File then Settings in the toolbar for Windows and Linux. For Mac, go to Android Studio then Preferences.
  - Choose Version Control from the left menu then TFVC.
  - In the Path to tf executable text field, navigate to the location of the tf executable. => 指到剛才解壓的 tf.cmd 
  - Click Test to test that the executable has been found and is working as expected.
  - Click Apply then OK to save and exit.

- 試著從 Rider > Get From Version Control 來複製 TFVC 的 Repository

[參考資料](https://docs.microsoft.com/en-us/azure/devops/java/intellij-faq?view=azure-devops#does-the-intellij-plug-in-support-tfvc)