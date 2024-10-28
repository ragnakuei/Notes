# 加入 WebService 的方式


專案 > Add > Connected Service

![01](./_images/加入%20WebService%20的方式/01.png)

Connected Service > Microsoft WCF Web Service Reference Provider

![02](./_images/加入%20WebService%20的方式/02.png)

輸入 Web Service URL > 按下 GO > 選到對應的 Soap Service 就會列出 Operations 了

![03](./_images/加入%20WebService%20的方式/03.png)

後續呼叫時，是以 new XXXSoapClient() 的方式呼叫

注意
- 如果以 Browser 瀏覽該 WebService 時，沒有出現 Inoke 的按鈕，就會讓該 WebService 無法被加入 !
  - 已知情境
    - 該 Operation 的參數型別是自定義型別